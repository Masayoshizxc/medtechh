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
        navigationController?.navigationBar.isHidden = false
        emailField.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubviews(
            firstLabel,
            secondLabel,
            emailField,
            sendButton
        )
        setUpConstraints()
    }
    
    @objc func didTapSendButton() {
        guard let email = emailField.text, !email.isEmpty else {
            print("Enter email")
            emailField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        view.makeToastActivity(.center)
        viewModel.forgotPassword(email: email) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success:
                strongSelf.view.hideToastActivity()
                let sheet = UIAlertController(title: "Успешно", message: "На вашу почту отправлен код.", preferredStyle: .alert)
                sheet.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                    let vc = CodeViewController()
                    vc.email = email
                    strongSelf.navigationController?.pushViewController(vc, animated: true)
                    strongSelf.dismiss(animated: true)
                }))
                strongSelf.present(sheet, animated: true)
            case .failure:
                DispatchQueue.main.async {
                    strongSelf.view.hideToastActivity()
                }
                strongSelf.emailField.layer.borderColor = UIColor.red.cgColor
            default:
                break
            }
        }
        
        
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
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(60)
            make.left.right.equalToSuperview().inset(16)
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
