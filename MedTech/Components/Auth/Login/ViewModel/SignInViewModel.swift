//
//  SignInViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 5/7/22.
//

import Foundation

protocol SignInViewModelProtocol {
    func signIn(email: String, password: String, completion: @escaping ((SuccessFailure?) -> Void))
    var model: SignIn? { get set }
}

class SignInViewModel: SignInViewModelProtocol {
    
    let userDefaults = UserDefaultsService.shared
    private let service: SignInServiceProtocol
    
    var model: SignIn?

    init(vm: SignInServiceProtocol = SignInService()) {
        service = vm
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func signIn(email: String, password: String, completion: @escaping ((SuccessFailure?) -> Void)) {
        guard validateEmail(enteredEmail: email) else {
            completion(.failure)
            return
        }
        
        let parameters: [String : Any] = [
            "email" : email,
            "password" : password
        ]
        let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        guard let data = data else {
            return
        }
        service.signIn(data: data) { result in
            if result != nil {
                self.model = result
                let isPatient = self.model?.roles.contains("ROLE_PATIENT")
                switch isPatient {
                case true:
                    guard let userData = self.model else {
                        return
                    }
                    self.userDefaults.saveUserId(id: userData.id)
                    self.userDefaults.saveRefreshToken(name: self.model?.refreshToken)
                    self.userDefaults.saveAccessToken(name: self.model?.token)
                    self.userDefaults.isSignedIn(signedIn: true)
                    completion(.success)
                case false:
                    completion(.failure)
                    break
                default:
                    break
                }
            } else {
                completion(.failure)
            }
            
        }
    }
    
    func validateEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
}
