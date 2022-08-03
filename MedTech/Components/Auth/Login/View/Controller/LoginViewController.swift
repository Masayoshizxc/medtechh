//
//  LoginViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    
    var isHidden = true
    
    let userDefaults = UserDefaultsService()
    
    private let viewModel: SignInViewModelProtocol

    init(vm: SignInViewModelProtocol = SignInViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let alertIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.error.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let alertLabel: UILabel = {
        let label = UILabel()
        label.text = "Неверный email или пароль"
        label.font = Fonts.SFProText.medium.font(size: 16)
        label.textColor = UIColor(red: 0.921, green: 0.385, blue: 0.385, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = Fonts.SFProText.semibold.font(size: 24)
        label.textColor = UIColor(named: "Violet")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailField: EmailTextField = {
        let field = EmailTextField()
        field.attributedPlaceholder = (NSAttributedString(string: "Электронная почта", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Violet")]) as Any as! NSAttributedString)
        field.returnKeyType = .continue
        return field
    }()
    
    let passwordField: PasswordTextField = {
        let field = PasswordTextField()
        field.attributedPlaceholder = NSAttributedString(string: "Пароль",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Violet") as Any])
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
        button.setTitleColor(UIColor(named: "Violet"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 14)
        return button
    }()
    
    private lazy var hideButton: HideButton = {
        let button = HideButton()
        button.addTarget(self, action: #selector(didTapHideButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        view.addSubviews(
            alertIcon,
            alertLabel,
            secondLabel,
            emailField,
            passwordField,
            loginButton,
            forgotPasswordButton,
            hideButton
        )
        
        alertIcon.isHidden = true
        alertLabel.isHidden = true
        
        emailField.delegate = self
        passwordField.delegate = self
        
        setUpConstraints()
    }
    
    @objc func didTapLoginButton() {
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty else {
            alertIcon.isHidden = false
            alertLabel.isHidden = false
            alertLabel.text = "Enter email or password"
            emailField.layer.borderColor = UIColor.red.cgColor
            passwordField.layer.borderColor = UIColor.red.cgColor
            return
        }
        view.makeToastActivity(.center)
        if validateEmail(enteredEmail: email) {
            let parameters: [String : Any] = [
                "email" : email,
                "password" : password
            ]
            let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            viewModel.signIn(data: data!) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                if result != nil {
                    let isPatient = result?.roles.contains("ROLE_PATIENT")
                    if isPatient! {
                        let userData = result!
                        strongSelf.userDefaults.saveUserId(id: userData.id)
                        strongSelf.userDefaults.saveRefreshToken(name: result?.refreshToken)
                        strongSelf.userDefaults.saveAccessToken(name: result?.token)
                        strongSelf.userDefaults.isSignedIn(signedIn: true)
                        if result?.pwdChangeRequired ?? false {
                            let vc = NewPasswordViewController()
                            strongSelf.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            let vc = TabBarViewController()
                            strongSelf.navigationController?.pushViewController(vc, animated: true)
                        }
                    } else {
                        strongSelf.view.hideToastActivity()
                        strongSelf.alertIcon.isHidden = false
                        strongSelf.alertLabel.isHidden = false
                        strongSelf.alertLabel.text = "Неверный email или пароль"
                        strongSelf.emailField.layer.borderColor = UIColor.red.cgColor
                        strongSelf.passwordField.layer.borderColor = UIColor.red.cgColor
                    }
                } else {
                    DispatchQueue.main.async {
                        strongSelf.view.hideToastActivity()
                        strongSelf.alertIcon.isHidden = false
                        strongSelf.alertLabel.isHidden = false
                        strongSelf.alertLabel.text = "Неверный email или пароль"
                        strongSelf.emailField.layer.borderColor = UIColor.red.cgColor
                        strongSelf.passwordField.layer.borderColor = UIColor.red.cgColor
                    }
                }
                
            }
            
        } else {
            view.hideToastActivity()
            alertIcon.isHidden = false
            alertLabel.isHidden = false
            alertLabel.text = "Wrong email"
            emailField.layer.borderColor = UIColor.red.cgColor
            passwordField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    @objc func didTapForgotPasswordButton() {
        let vc = ForgotPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapHideButton(_ sender: UIButton) {
        if isHidden {
            hideButton.setImage(Icons.unhide.image, for: .normal)
            passwordField.isSecureTextEntry = false
        } else {
            hideButton.setImage(Icons.hide.image, for: .normal)
            passwordField.isSecureTextEntry = true
        }
        isHidden = !isHidden
    }
    
    func validateEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    func setUpConstraints() {
        alertIcon.snp.makeConstraints { make in
            make.right.equalTo(alertLabel.snp.left).offset(-10)
            make.centerY.equalTo(alertLabel.snp.centerY)
        }
        
        alertLabel.snp.makeConstraints { make in
            make.bottom.equalTo(emailField.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(emailField.snp.top).offset(-70)
        }
        
        emailField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(passwordField.snp.top).offset(-25)
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
        
        hideButton.snp.makeConstraints { make in
            make.right.equalTo(passwordField.snp.right).offset(-15)
            make.centerY.equalTo(passwordField.snp.centerY)
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
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if emailField.text!.count >= 1 {
            loginButton.backgroundColor = UIColor(named: "Violet")            
        }
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

