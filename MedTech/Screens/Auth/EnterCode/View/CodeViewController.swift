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
        stack.spacing = 10.0
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
        button.setTitle("Enter", for: .normal)
        button.addTarget(self, action: #selector(didTapEnter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
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
        
        
        
        view.addSubviews(stackView, enterButton)
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
            print("Code is: \(result)")
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
    
    func setUpConstraints() {
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(50)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(60)
        }
        
        codeField1.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        codeField2.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        codeField3.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        codeField4.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        codeField5.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        codeField6.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
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

