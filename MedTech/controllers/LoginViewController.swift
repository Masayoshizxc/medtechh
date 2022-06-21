//
//  LoginViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите ваши данные"
        label.font = UIFont(name: "Mulish-Black", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Пожалуйста введите свои данные"
        label.font = UIFont(name: "Mulish-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: "Почта", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        field.font = UIFont(name: "Mulish-ExtraBold", size: 16)
        field.textAlignment = .center
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = UIColor(red: 1, green: 0.982, blue: 0.9, alpha: 0.4)
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.yellow.cgColor
        field.layer.cornerRadius = 25
        return field
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        field.font = UIFont(name: "Mulish-ExtraBold", size: 16)
        field.textAlignment = .center
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.yellow.cgColor
        field.layer.cornerRadius = 25
        return field
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 1, green: 0.941, blue: 0.667, alpha: 1)
        button.layer.cornerRadius = 25
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Mulish-ExtraBold", size: 17)
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
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 0.975, green: 0.528, blue: 0.648, alpha: 1.0).cgColor,
            UIColor(red: 0.967, green: 0.919, blue: 0.685, alpha: 1.0).cgColor
        ]
        view.layer.addSublayer(gradientLayer)
        
//        view.addSubview(firstLabel)
//        view.addSubview(secondLabel)
//        view.addSubview(emailField)
//        view.addSubview(passwordField)
//        view.addSubview(loginButton)
//        view.addSubview(forgotPasswordButton)
        view.addSubviews(
            firstLabel,
            secondLabel,
            emailField,
            passwordField,
            loginButton,
            forgotPasswordButton
        )
        setUpConstraints()
    }
    
    @objc func didTapLoginButton() {
        let vc = NewPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapForgotPasswordButton() {
        let vc = ForgotPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)

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

