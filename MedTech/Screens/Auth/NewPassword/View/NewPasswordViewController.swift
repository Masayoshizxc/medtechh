//
//  NewPasswordViewController.swift
//  MedTech
//
//  Created by Eldiiar on 17/6/22.
//

import UIKit

class NewPasswordViewController: BaseViewController {
    
    let userDefaults = UserDefaultsService()
    
    private let viewModel: NewPasswordViewModelProtocol

    init(vm: NewPasswordViewModelProtocol = NewPasswordViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isForgetPassword = false
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Пожалуйста введите новый пароль"
        label.font = Fonts.Mulish.black.font(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordField: PasswordTextField = {
        let field = PasswordTextField()
        field.attributedPlaceholder = NSAttributedString(string: "Новый Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        field.returnKeyType = .continue
        return field
    }()
    
    let confirmPasswordField: PasswordTextField = {
        let field = PasswordTextField()
        field.attributedPlaceholder = NSAttributedString(string: "Повторите Новый Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return field
    }()
    
    private lazy var loginButton: LoginButton = {
        let button = LoginButton()
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(passwordField)
        view.addSubview(confirmPasswordField)
        view.addSubview(loginButton)
        
        view.addSubviews(
            label,
            passwordField,
            confirmPasswordField,
            loginButton
        )
        
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        
        setUpConstraints()
    }
    
    
    @objc func didTapLoginButton() {
        guard let password = passwordField.text,
              let confirmPassword = confirmPasswordField.text,
              !password.isEmpty,
              !confirmPassword.isEmpty else {
            print("Enter password")
            return
        }
        guard password == confirmPassword else {
            print("passwords are not the save")
            return
        }
        
        let userId = userDefaults.getUserId()
        
        viewModel.changePassword(id: userId, password: password) { result in
            print("New password result: \(String(describing: result))")
        }
        
        if isForgetPassword {
            let vc = LoginViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = TabBarViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func setUpConstraints() {
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(passwordField.snp.top).offset(-70)
        }
        passwordField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(confirmPasswordField.snp.top).offset(-20)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        confirmPasswordField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(confirmPasswordField.snp.bottom).offset(30)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
    }

}

extension NewPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordField {
            confirmPasswordField.becomeFirstResponder()
        } else {
            didTapLoginButton()
        }
        return true
    }
}
