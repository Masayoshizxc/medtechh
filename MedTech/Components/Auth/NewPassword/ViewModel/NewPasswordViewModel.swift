//
//  NewPasswordViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import Foundation

protocol NewPasswordViewModelProtocol {
    func changePassword(id: Int, oldPassword: String?, newPassword: String, completion: @escaping ((FailureModel?) -> Void))
}

class NewPasswordViewModel: NewPasswordViewModelProtocol {
    
    private let service: NewPasswordServiceProtocol
    private let userDefaults = UserDefaultsService()
    
    init(vm: NewPasswordServiceProtocol = NewPasswordService()) {
        service = vm
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changePassword(id: Int, oldPassword: String?, newPassword: String, completion: @escaping ((FailureModel?) -> Void)) {
        service.changePassword(id: id, oldPassword: oldPassword, newPassword: newPassword) { result in
            completion(result)
        }
    }
}
