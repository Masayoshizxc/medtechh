//
//  CodeViewController.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import UIKit

class CodeViewController: BaseViewController {
    
    let userDefaults = UserDefaultsService()
    private let forgotViewModel: ForgotPasswordViewModelProtocol
    private let viewModel: CodeViewModelProtocol

    init(vm: CodeViewModelProtocol = CodeViewModel(), fvm: ForgotPasswordViewModelProtocol = ForgotPasswordViewModel()) {
        viewModel = vm
        forgotViewModel = fvm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var email = ""
    var time = 60
    var timer = Timer()
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код"
        label.font = Fonts.SFProText.semibold.font(size: 24)
        label.textColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.text = "6-значный код был отправлен на вашу электронную почту \(email)"
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
        button.setTitle("Отправить повторно 60", for: .normal)
        button.titleLabel?.font = Fonts.SFProText.medium.font(size: 16)
        button.setTitleColor(UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(didTapResend), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeField1.delegate = self
        codeField2.delegate = self
        codeField3.delegate = self
        codeField4.delegate = self
        codeField5.delegate = self
        codeField6.delegate = self
        codeField1.becomeFirstResponder()
        
        resendButton.isEnabled = false
        
        view.addSubviews(firstLabel, secondLabel, stackView, enterButton, resendButton)
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        time -= 1
        resendButton.setTitle("Отправить повторно \(time)", for: .normal)
        if time == 0 {
            timer.invalidate()
            resendButton.setTitle("Отправить повторно", for: .normal)
            resendButton.isEnabled = true
            resendButton.setTitleColor(UIColor(named: "Violet"), for: .normal)
        }
    }
    
    @objc func didTapEnter() {
//        guard !codeField1.text!.isEmpty, !codeField2.text!.isEmpty, !codeField3.text!.isEmpty, !codeField4.text!.isEmpty, !codeField5.text!.isEmpty,
//              !codeField6.text!.isEmpty else {
//            print("Text Field is empty")
//            return
//        }
        let code = codeField1.text! + codeField2.text! + codeField3.text! + codeField4.text! + codeField5.text! + codeField6.text!
        guard !code.isEmpty else {
            error()
            return
        }
        
        viewModel.enterCode(code: code) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            guard let id = strongSelf.viewModel.code?.id else {
                return
            }
            switch result {
            case .success:
                strongSelf.userDefaults.saveUserId(id: id)
                let vc = NewPasswordViewController()
                vc.isForgetPassword = true
                strongSelf.navigationController?.pushViewController(vc, animated: true)
            case .failure:
                DispatchQueue.main.async {
                    strongSelf.error()
                    strongSelf.codeField1.text = nil
                    strongSelf.codeField2.text = nil
                    strongSelf.codeField3.text = nil
                    strongSelf.codeField4.text = nil
                    strongSelf.codeField5.text = nil
                    strongSelf.codeField6.text = nil
                    strongSelf.codeField1.becomeFirstResponder()
                }
            default:
                break
            }
        }
    }
    
    @objc func didTapResend() {
        view.makeToastActivity(.center)
        forgotViewModel.forgotPassword(email: email) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    strongSelf.view.hideToastActivity()
                    let sheet = UIAlertController(title: "Успешно", message: "На вашу почту отправлен код.", preferredStyle: .alert)
                    sheet.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                        strongSelf.time = 60
                        strongSelf.timer = Timer.scheduledTimer(timeInterval: 1, target: strongSelf, selector: #selector(strongSelf.update), userInfo: nil, repeats: true)
                        strongSelf.dismiss(animated: true)
                    }))
                    strongSelf.present(sheet, animated: true)
                }
            case .failure:
                strongSelf.view.hideToastActivity()
                strongSelf.error()
            default:
                break
            }
        }
    }
    
    func error() {
        codeField1.layer.borderColor = UIColor(red: 0.921, green: 0.385, blue: 0.385, alpha: 1).cgColor
        codeField2.layer.borderColor = UIColor(red: 0.921, green: 0.385, blue: 0.385, alpha: 1).cgColor
        codeField3.layer.borderColor = UIColor(red: 0.921, green: 0.385, blue: 0.385, alpha: 1).cgColor
        codeField4.layer.borderColor = UIColor(red: 0.921, green: 0.385, blue: 0.385, alpha: 1).cgColor
        codeField5.layer.borderColor = UIColor(red: 0.921, green: 0.385, blue: 0.385, alpha: 1).cgColor
        codeField6.layer.borderColor = UIColor(red: 0.921, green: 0.385, blue: 0.385, alpha: 1).cgColor
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
            make.centerY.equalToSuperview().dividedBy(1.2)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(27)
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
        let text = textField.text
        if text?.count == 1 {
            switch textField {
            case codeField1:
                enterButton.backgroundColor = UIColor(red: 0.361, green: 0.282, blue: 0.416, alpha: 1)
                codeField2.becomeFirstResponder()
            case codeField2:
                codeField3.becomeFirstResponder()
            case codeField3:
                codeField4.becomeFirstResponder()
            case codeField4:
                codeField5.becomeFirstResponder()
            case codeField5:
                codeField6.becomeFirstResponder()
            case codeField6:
                codeField6.resignFirstResponder()
            default:
                break
            }
        }
        
        if text?.count == 0 {
            switch textField {
            case codeField1:
                enterButton.backgroundColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1)
                codeField1.becomeFirstResponder()
            case codeField2:
                codeField1.becomeFirstResponder()
            case codeField3:
                codeField2.becomeFirstResponder()
            case codeField4:
                codeField3.becomeFirstResponder()
            case codeField5:
                codeField4.becomeFirstResponder()
            case codeField6:
                codeField5.becomeFirstResponder()
            default:
                break
            }
        }

        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return allowedCharacters.isSuperset(of: characterSet) && updatedText.count < 2
    }
    
    
}

