//
//  SignInService.swift
//  MedTech
//
//  Created by Eldiiar on 5/8/22.
//

import Foundation

protocol SignInServiceProtocol {
    func signIn(data: Data, completion: @escaping ((SignIn?) -> Void))
}

class SignInService: SignInServiceProtocol {
    let networkService: NetworkService = NetworkService()
    
    func signIn(data: Data, completion: @escaping ((SignIn?) -> Void)) {
        networkService.sendRequest(urlRequest: AuthRouter.signIn(data: data).createURLRequest(),
                                   successModel: SignIn.self) { result in
            switch result {
            case .success(let model):
                completion(model)
            case .badRequest(let error):
                completion(nil)
                debugPrint(#function, error)
            case .failure(let error):
                completion(nil)
                debugPrint(#function, error)
            case .unauthorized(let error):
                completion(nil)
                debugPrint(#function, error)
            case .notFound(let error):
                completion(nil)
                debugPrint(#function, error)
            }
        }
    }
}
