//
//  ForgotPasswordViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import Foundation

protocol ForgotPasswordViewModelProtocol {
    func forgotPassword(email: String, completion: @escaping ((FailureModel?) -> Void))
}

class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    let networkService: NetworkService = NetworkService()
    
    private let service: ForgotPasswordServiceProtocol
    private let userDefaults = UserDefaultsService()
    
    init(vm: ForgotPasswordServiceProtocol = ForgotPasswordService()) {
        service = vm
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func forgotPassword(email: String, completion: @escaping ((FailureModel?) -> Void)) {
        service.forgotPassword(email: email) { result in
            completion(result)
        }
    }
}
