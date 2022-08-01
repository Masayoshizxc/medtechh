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
    var isHidden = true
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Создание нового пароля"
        label.font = Fonts.SFProText.semibold.font(size: 24)
        label.textColor = UIColor(named: "Violet")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordField: PasswordTextField = {
        let field = PasswordTextField()
        field.attributedPlaceholder = NSAttributedString(string: "Новый Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.624, green: 0.624, blue: 0.624, alpha: 1)])
        field.returnKeyType = .continue
        return field
    }()
    
    let confirmPasswordField: PasswordTextField = {
        let field = PasswordTextField()
        field.attributedPlaceholder = NSAttributedString(string: "Повторите Новый Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.624, green: 0.624, blue: 0.624, alpha: 1)])
        return field
    }()
    
    private lazy var loginButton: LoginButton = {
        let button = LoginButton()
        button.setTitle("Сохранить пароль", for: .normal)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var hideButton1: HideButton = {
        let button = HideButton()
        button.addTarget(self, action: #selector(didTapHideButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var hideButton2: HideButton = {
        let button = HideButton()
        button.addTarget(self, action: #selector(didTapHideButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor(named: "Violet")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.addSubviews(
            label,
            passwordField,
            confirmPasswordField,
            loginButton,
            hideButton1,
            hideButton2
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
            view.hideToastActivity()
            passwordField.layer.borderColor = UIColor.red.cgColor
            confirmPasswordField.layer.borderColor = UIColor.red.cgColor
            print("Enter password")
            return
        }
        guard password == confirmPassword else {
            view.hideToastActivity()
            passwordField.layer.borderColor = UIColor.red.cgColor
            confirmPasswordField.layer.borderColor = UIColor.red.cgColor
            print("passwords are not the save")
            return
        }
        
        let userId = userDefaults.getUserId()
        
        viewModel.changePassword(id: userId, oldPassword: nil, newPassword: password) { [weak self] result in
            print("New password result: \(String(describing: result))")
            guard let strongSelf = self else {
                return
            }
            strongSelf.view.makeToastActivity(.center)
            if result != nil {
                let sheet = UIAlertController(title: "Успешно", message: "Пароль успешно изменён !", preferredStyle: .alert)
                sheet.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                    if strongSelf.isForgetPassword {
                        let vc = LoginViewController()
                        strongSelf.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        let vc = TabBarViewController()
                        strongSelf.navigationController?.pushViewController(vc, animated: true)
                    }
                    strongSelf.dismiss(animated: true)
                }))
                strongSelf.present(sheet, animated: true)
            } else {
                strongSelf.view.hideToastActivity()
                strongSelf.passwordField.layer.borderColor = UIColor.red.cgColor
                strongSelf.confirmPasswordField.layer.borderColor = UIColor.red.cgColor
            }
        }
        
        
        
    }
    
    @objc func didTapHideButton(_ sender: UIButton) {
        if sender == hideButton1 {
            if isHidden {
                hideButton1.setImage(Icons.unhide.image, for: .normal)
                passwordField.isSecureTextEntry = false
            } else {
                hideButton1.setImage(Icons.hide.image, for: .normal)
                passwordField.isSecureTextEntry = true
            }
        } else {
            if isHidden {
                hideButton2.setImage(Icons.unhide.image, for: .normal)
                confirmPasswordField.isSecureTextEntry = false
            } else {
                hideButton2.setImage(Icons.hide.image, for: .normal)
                confirmPasswordField.isSecureTextEntry = true
            }
        }
        isHidden = !isHidden
    }
    
    func setUpConstraints() {
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(passwordField.snp.top).offset(-90)
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
            make.top.equalTo(confirmPasswordField.snp.bottom).offset(40)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        hideButton1.snp.makeConstraints { make in
            make.right.equalTo(passwordField.snp.right).offset(-15)
            make.centerY.equalTo(passwordField.snp.centerY)
        }
        hideButton2.snp.makeConstraints { make in
            make.right.equalTo(confirmPasswordField.snp.right).offset(-15)
            make.centerY.equalTo(confirmPasswordField.snp.centerY)
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if passwordField.text!.count >= 1 {
            loginButton.backgroundColor = UIColor(named: "Violet")
        }
    }
}
