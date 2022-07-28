//
//  ForgotPasswordViewController.swift
//  MedTech
//
//  Created by Eldiiar on 17/6/22.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {
    
    private let viewModel: ForgotPasswordViewModelProtocol

    init(vm: ForgotPasswordViewModelProtocol = ForgotPasswordViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите электронную почту"
        label.font = Fonts.SFProText.semibold.font(size: 24)
        label.textColor = UIColor(named: "Violet")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Код подтверждения будет выслан на вашу электронную почту"
        label.font = Fonts.SFProText.medium.font(size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailField: EmailTextField = {
        let field = EmailTextField()
        field.attributedPlaceholder = NSAttributedString(string: "Электронная почта", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)])
        return field
    }()
    
    private lazy var sendButton: LoginButton = {
        let button = LoginButton()
        button.setTitle("Подтвердить", for: .normal)
        button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor(named: "Violet")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        view.addSubviews(
            firstLabel,
            secondLabel,
            emailField,
            sendButton
        )
        
        emailField.delegate = self
        
        setUpConstraints()
    }
    
    @objc func didTapSendButton() {
        guard let email = emailField.text, !email.isEmpty else {
            print("Enter email")
            return
        }
        
        if validateEmail(enteredEmail: email) {
            viewModel.forgotPassword(email: email) { [weak self] result in
                print("Forgot password: \(String(describing: result))")
                if result?.errors == nil {
                    let vc = CodeViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    print("There was a problem with sending code")
                }
            }
        } else {
            print("Enter proper email")
        }
        
        
    }
    
    func validateEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    func setUpConstraints() {
        firstLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(secondLabel.snp.top).offset(-80)
        }
        secondLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(emailField.snp.top).offset(-60)
            make.width.equalTo(292)
        }
        emailField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        sendButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailField.snp.bottom).offset(60)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
    }
    
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if emailField.text!.count >= 1 {
            sendButton.backgroundColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        }
    }
}
