//
//  CodeService.swift
//  MedTech
//
//  Created by Eldiiar on 6/8/22.
//

import Foundation

protocol CodeServiceProtocol {
    func enterCode(code: String, completion: @escaping ((CodeModel?) -> Void))
}

class CodeService: CodeServiceProtocol {
    let networkService: NetworkService = NetworkService()
    
    func enterCode(code: String, completion: @escaping ((CodeModel?) -> Void)) {
        networkService.sendRequest(urlRequest: ForgotPasswordRouter.resetPassword(code: code).createURLRequest(),
                                   successModel: CodeModel.self) { result in
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
