//
//  NewPasswordSerivce.swift
//  MedTech
//
//  Created by Eldiiar on 6/8/22.
//

import Foundation

protocol NewPasswordServiceProtocol {
    func changePassword(id: Int, oldPassword: String?, newPassword: String, completion: @escaping ((FailureModel?) -> Void))
}

class NewPasswordService: NewPasswordServiceProtocol {
    let networkService: NetworkService = NetworkService()
    
    func changePassword(id: Int, oldPassword: String?, newPassword: String, completion: @escaping ((FailureModel?) -> Void)) {
        networkService.sendRequest(urlRequest: UserRouter.changePassword(id: id, oldPassword: oldPassword, newPassword: newPassword).createURLRequest(),
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
