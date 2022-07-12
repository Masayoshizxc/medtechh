//
//  CodeViewController.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import UIKit

class CodeViewController: UIViewController {
    
    let userDefaults = UserDefaultsService()

    private let viewModel: CodeViewModelProtocol

    init(vm: CodeViewModelProtocol = CodeViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код"
        label.font = Fonts.SFProText.semibold.font(size: 24)
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "6-значный код был отправлен на вашу электронную почту example@gmail.com"
        label.font = Fonts.SFProText.medium.font(size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let codeField1: CodeTextField = {
        let field = CodeTextField()
        return field
    }()
    
    private let codeField2: CodeTextField = {
        let field = CodeTextField()
        return field
    }()
    private let codeField3: CodeTextField = {
        let field = CodeTextField()
        return field
    }()
    
    private let codeField4: CodeTextField = {
        let field = CodeTextField()
        return field
    }()
    private let codeField5: CodeTextField = {
        let field = CodeTextField()
        return field
    }()
    
    private let codeField6: CodeTextField = {
        let field = CodeTextField()
        return field
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        [codeField1,
         codeField2,
         codeField3,
         codeField4,
         codeField5,
         codeField6].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подтвердить", for: .normal)
        button.addTarget(self, action: #selector(didTapEnter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
        button.layer.cornerRadius = 18
        return button
    }()
    
    private lazy var resendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить повторно", for: .normal)
        button.titleLabel?.font = Fonts.SFProText.medium.font(size: 16)
        button.setTitleColor(UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(didTapResend), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        codeField1.delegate = self
        codeField2.delegate = self
        codeField3.delegate = self
        codeField4.delegate = self
        codeField5.delegate = self
        codeField6.delegate = self
        
        
        
        view.addSubviews(firstLabel, secondLabel, stackView, enterButton, resendButton)
        setUpConstraints()
    }
    
    @objc func didTapEnter() {
//        guard !codeField1.text!.isEmpty, !codeField2.text!.isEmpty, !codeField3.text!.isEmpty, !codeField4.text!.isEmpty, !codeField5.text!.isEmpty,
//              !codeField6.text!.isEmpty else {
//            print("Text Field is empty")
//            return
//        }
let code = codeField1.text! + codeField2.text! + codeField3.text! + codeField4.text! + codeField5.text! + codeField6.text!
//        guard !code.isEmpty else {
//            print("Code is empty")
//            return
//        }
        print(code)
        viewModel.enterCode(code: code) { [weak self] result in
            print("Code is: \(String(describing: result))")
            if result?.id != nil {
                self?.userDefaults.saveUserId(id: result!.id!)
                let vc = NewPasswordViewController()
                vc.isForgetPassword = true
                self?.navigationController?.pushViewController(vc, animated: true)
            } else {
                print("error")
            }

        }
    }
    
    @objc func didTapResend() {
        print("Resend Tapped!")
    }
    
    func setUpConstraints() {
        firstLabel.snp.makeConstraints { make in
            make.bottom.equalTo(secondLabel.snp.top).offset(-40)
            make.centerX.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.top).offset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(301)
        }
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().dividedBy(1.2)
            make.width.equalToSuperview().dividedBy(1.2)
            make.height.equalTo(50)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(336)
            make.height.equalTo(60)
        }
        
        resendButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(enterButton.snp.bottom).offset(30)
        }
    }

}

extension CodeViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if codeField1.text?.count == 1 {
            codeField2.becomeFirstResponder()
        }
        if codeField2.text?.count == 1 {
            codeField3.becomeFirstResponder()
        }
        if codeField3.text?.count == 1 {
            codeField4.becomeFirstResponder()
        }
        if codeField4.text?.count == 1 {
            codeField5.becomeFirstResponder()
        }
        if codeField5.text?.count == 1 {
            codeField6.becomeFirstResponder()
        }
    }
}

