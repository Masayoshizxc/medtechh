//
//  ForgotPasswordViewController.swift
//  MedTech
//
//  Created by Eldiiar on 17/6/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Пожалуйста, введите ваш e-mail"
        label.font = UIFont(name: "Mulish-Black", size: 22)
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
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Получить письмо", for: .normal)
        button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
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
        
        view.addSubview(firstLabel)
        view.addSubview(emailField)
        view.addSubview(sendButton)
        setUpConstraints()
    }
    
    @objc func didTapSendButton() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpConstraints() {
        firstLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(emailField.snp.top).offset(-80)
        }
        emailField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        sendButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailField.snp.bottom).offset(30)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
    }

}
