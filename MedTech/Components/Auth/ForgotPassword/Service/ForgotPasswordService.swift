//
//  ForgotPasswordService.swift
//  MedTech
//
//  Created by Eldiiar on 6/8/22.
//

import Foundation

protocol ForgotPasswordServiceProtocol {
    func forgotPassword(email: String, completion: @escaping ((FailureModel?) -> Void))
}

class ForgotPasswordService: ForgotPasswordServiceProtocol {
    let networkService: NetworkService = NetworkService()
    
    func forgotPassword(email: String, completion: @escaping ((FailureModel?) -> Void)) {
        networkService.sendRequest(urlRequest: ForgotPasswordRouter.forgotPassword(email: email).createURLRequest(),
                                   successModel: FailureModel.self) { result in
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
