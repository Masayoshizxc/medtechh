//
//  PasswordViewController.swift
//  MedTech
//
//  Created by Eldiiar on 27/7/22.
//

import UIKit

class PasswordViewController: BaseViewController {
    
    let userDefaults = UserDefaultsService()
    
    private let viewModel: NewPasswordViewModelProtocol

    init(vm: NewPasswordViewModelProtocol = NewPasswordViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let oldPassword: PasswordTextField = {
        let field = PasswordTextField()
        field.placeholder = "Old password"
        return field
    }()
    
    private let newPassword1: PasswordTextField = {
        let field = PasswordTextField()
        field.placeholder = "New password"
        return field
    }()
    
    private let newPassword2: PasswordTextField = {
        let field = PasswordTextField()
        field.placeholder = "New password again"
        return field
    }()
    
    private lazy var confirmButton: LoginButton = {
        let button = LoginButton()
        button.setTitle("Confirm", for: .normal)
        button.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(
            oldPassword,
            newPassword1,
            newPassword2,
            confirmButton
        )
        
        setUpConstraints()
    }
    
    @objc func didTapConfirmButton() {
        guard let old = oldPassword.text, let new1 = newPassword1.text, let new2 = newPassword2.text else {
            return
        }
        
        guard old.count > 8, new1.count > 8, new2.count > 8 else {
            print("Password should be more than 8 characters")
            return
        }
        
        guard new1 == new2 else {
            print("New password are not the same")
            return
        }
        let userId = userDefaults.getUserId()
        viewModel.changePassword(id: userId, oldPassword: old, newPassword: new1) { result in
            print(result)
        }
    }
    
    func setUpConstraints() {
        oldPassword.snp.makeConstraints { make in
            make.bottom.equalTo(newPassword1.snp.top).offset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(336)
            make.height.equalTo(50)
        }
        
        newPassword1.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(336)
            make.height.equalTo(50)
        }
        
        newPassword2.snp.makeConstraints { make in
            make.top.equalTo(newPassword1.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(336)
            make.height.equalTo(50)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(newPassword2.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(336)
            make.height.equalTo(50)
        }
    }
    

}
