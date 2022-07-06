//
//  ProfileViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import Foundation

protocol ProfileViewModelProtocol {
    func logOut(data: Data, completion: @escaping ((FailureModel?) -> Void))
}

class ProfileViewModel: ProfileViewModelProtocol {
    let networkService: NetworkService = NetworkService()
    
    func logOut(data: Data, completion: @escaping ((FailureModel?) -> Void)) {
        networkService.sendRequest(urlRequest: AuthRouter.logout(data: data).createURLRequest(),
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
