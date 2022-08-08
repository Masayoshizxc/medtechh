//
//  NewPasswordViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import Foundation

protocol NewPasswordViewModelProtocol {
    func changePassword(oldPassword: String?, newPassword: String, completion: @escaping ((SuccessFailure?) -> Void))
}

class NewPasswordViewModel: NewPasswordViewModelProtocol {
    
    private let service: NewPasswordServiceProtocol
    
    init(vm: NewPasswordServiceProtocol = NewPasswordService()) {
        service = vm
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changePassword(oldPassword: String?, newPassword: String, completion: @escaping ((SuccessFailure?) -> Void)) {
        let userId = UserDefaultsService.shared.getUserId()
        service.changePassword(id: userId, oldPassword: oldPassword, newPassword: newPassword) { result in
            guard result != nil else {
                completion(.failure)
                return
            }
            completion(.success)
        }
    }
}
