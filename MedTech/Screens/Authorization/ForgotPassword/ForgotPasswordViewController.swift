//
//  ForgotPasswordViewController.swift
//  MedTech
//
//  Created by Eldiiar on 17/6/22.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Пожалуйста, введите ваш e-mail"
        label.font = UIFont(name: "Mulish-Black", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailField: EmailTextField = {
        let field = EmailTextField()
        field.attributedPlaceholder = NSAttributedString(string: "Почта", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return field
    }()
    
    private lazy var sendButton: LoginButton = {
        let button = LoginButton()
        button.setTitle("Получить письмо", for: .normal)
        button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        return button
    }()
    
//    private let gradientLayer: CAGradientLayer = {
//        let gradient = CAGradientLayer()
//        gradient.colors = [
//            UIColor(red: 0.975, green: 0.528, blue: 0.648, alpha: 1.0).cgColor,
//            UIColor(red: 0.967, green: 0.919, blue: 0.685, alpha: 1.0).cgColor
//        ]
//        return gradient
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(
            firstLabel,
            emailField,
            sendButton
        )
        
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
