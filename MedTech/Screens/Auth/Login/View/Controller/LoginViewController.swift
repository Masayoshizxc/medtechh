//
//  LoginViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    
    let userDefaults = UserDefaultsService()
    
    private let viewModel: SignInViewModelProtocol

    init(vm: SignInViewModelProtocol = SignInViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите ваши данные"
        label.font = Fonts.Mulish.black.font(size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Пожалуйста введите свои данные"
        label.font = Fonts.Mulish.bold.font(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailField: EmailTextField = {
        let field = EmailTextField()
        field.attributedPlaceholder = NSAttributedString(string: "Почта", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        field.returnKeyType = .continue
        return field
    }()
    
    let passwordField: PasswordTextField = {
        let field = PasswordTextField()
        field.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return field
    }()
    
    private lazy var loginButton: LoginButton = {
        let button = LoginButton()
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
        
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль ?", for: .normal)
        button.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(red: 0.078, green: 0.078, blue: 0.078, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Mulish-Bold", size: 17)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        
        view.addSubviews(
            firstLabel,
            secondLabel,
            emailField,
            passwordField,
            loginButton,
            forgotPasswordButton
        )
        
        emailField.delegate = self
        passwordField.delegate = self
        
        setUpConstraints()
    }
    
    @objc func didTapLoginButton() {
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty else {
            print("Enter email or password")
            return
        }

        if validateEmail(enteredEmail: email) {
            let parameters: [String : Any] = [
                "email" : email,
                "password" : password
            ]
            let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            viewModel.signIn(data: data!) { [weak self] result in
                let isPatient = result?.roles.contains("ROLE_PATIENT")
                if isPatient! {
                    print("True")
                    print(result!)
                    let userData = result!
                    self?.userDefaults.saveUserId(id: userData.id)
                    self?.userDefaults.saveRefreshToken(name: result?.refreshToken)
                    self?.userDefaults.saveAccessToken(name: result?.token)
                    self?.userDefaults.isSignedIn(signedIn: true)
                    if result?.pwdChangeRequired ?? false {
                        let vc = NewPasswordViewController()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        let vc = TabBarViewController()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    print("False. The users roles is not Patient")
                }
            }
            
        } else {
            print("Wrong email")
        }
    }
    
    @objc func didTapForgotPasswordButton() {
        let vc = ForgotPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)

    }
    
    func validateEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    func setUpConstraints() {
        firstLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(secondLabel.snp.top).offset(-20)
        }
        secondLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(emailField.snp.top).offset(-70)
        }
        emailField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(passwordField.snp.top).offset(-20)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        passwordField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordField.snp.bottom).offset(30)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        forgotPasswordButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(30)
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            didTapLoginButton()
        }
        return true
    }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

extension NSObject {
    @objc var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    @objc var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    func widthComputed(_ value: CGFloat) -> CGFloat {
        screenWidth * value / 390
    }
    
    func heightComputed(_ value: CGFloat) -> CGFloat {
        screenHeight * value / 844
    }
    
    var tabbarHeight: CGFloat {
        UITabBarController().tabBar.frame.height
    }
}

