//
//  SignInViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 5/7/22.
//

import Foundation

protocol SignInViewModelProtocol {
    func signIn(data: Data, completion: @escaping ((SuccessFailure?) -> Void))
    var model: SignIn? { get set }
}

class SignInViewModel: SignInViewModelProtocol {
    
    private let service: SignInServiceProtocol
    
    var model: SignIn?

    init(vm: SignInServiceProtocol = SignInService()) {
        service = vm
        //super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func signIn(data: Data, completion: @escaping ((SuccessFailure?) -> Void)) {
        service.signIn(data: data) { result in
            if result != nil {
                self.model = result
                completion(.success)
            } else {
                completion(.failure)
            }
            
        }
    }
}
