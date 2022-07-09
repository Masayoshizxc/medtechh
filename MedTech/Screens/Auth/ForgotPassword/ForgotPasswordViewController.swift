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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backItem?.title = ""

        view.addSubviews(
            firstLabel,
            emailField,
            sendButton
        )
        
        setUpConstraints()
    }
    
    @objc func didTapSendButton() {
        guard let email = emailField.text, !email.isEmpty else {
            print("Enter email")
            return
        }
        
        if validateEmail(enteredEmail: email) {
            viewModel.forgotPassword(email: email) { result in
                print("Forgot password: \(String(describing: result))")
            }
            let vc = CodeViewController()
            navigationController?.pushViewController(vc, animated: true)
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
