//
//  ForgotPasswordViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import Foundation

protocol ForgotPasswordViewModelProtocol {
    func forgotPassword(email: String, completion: @escaping ((SuccessFailure?) -> Void))
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
    
    func forgotPassword(email: String, completion: @escaping ((SuccessFailure?) -> Void)) {
        service.forgotPassword(email: email) { result in
            guard self.validateEmail(enteredEmail: email), result != nil else {
                completion(.failure)
                return
            }
            completion(.success)
        }
    }
    
    func validateEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
}
