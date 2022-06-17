//
//  NewPasswordViewController.swift
//  MedTech
//
//  Created by Eldiiar on 17/6/22.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Пожалуйста введите новый пароль"
        label.font = UIFont(name: "Mulish-Black", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: "Новый Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
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
    
    let confirmPasswordField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: "Повторите Новый Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
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

    override func viewDidLoad() {
        super.viewDidLoad()

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 0.975, green: 0.528, blue: 0.648, alpha: 1.0).cgColor,
            UIColor(red: 0.967, green: 0.919, blue: 0.685, alpha: 1.0).cgColor
        ]
        view.layer.addSublayer(gradientLayer)
        
        view.addSubview(label)
        view.addSubview(passwordField)
        view.addSubview(confirmPasswordField)
        view.addSubview(loginButton)
        setUpConstraints()
    }
    
    @objc func didTapLoginButton() {
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
