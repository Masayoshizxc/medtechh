//
//  NewPasswordViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import Foundation

protocol NewPasswordViewModelProtocol {
    func changePassword(id: Int, password: String, completion: @escaping ((FailureModel?) -> Void))
}

class NewPasswordViewModel: NewPasswordViewModelProtocol {
    let networkService: NetworkService = NetworkService()
    
    func changePassword(id: Int, password: String, completion: @escaping ((FailureModel?) -> Void)) {
        networkService.sendRequest(urlRequest: UserRouter.changePassword(id: id, password: password).createURLRequest(),
                                   successModel: FailureModel.self) { result in
            switch result {
            case .success(let model):
                
                //print(model)
                completion(model)
            case .badRequest(let error):
                completion(nil)
                debugPrint(#function, error)
            case .failure(let error):
                completion(nil)
                debugPrint(#function, error)
//            case .forbidden(let error):
//                completion(nil)
//                debugPrint(#function, error)
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
