//
//  ProfileViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import Foundation

protocol ProfileViewModelProtocol {
    func logOut(data: Data, completion: @escaping ((FailureModel?) -> Void))
    func getPatient(id: Int, completion: @escaping ((Patient?) -> Void))
    func getAddressAndPhone(id: Int, address: String, phone: String, completion: @escaping ((Patient?) -> Void))
    func addImage(id: Int, image: Data, completion: @escaping ((Patient?) -> Void))
    func changeImage(id: Int, image: Data, completion: @escaping ((Patient?) -> Void))
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
    
    func getPatient(id: Int, completion: @escaping ((Patient?) -> Void)) {
        networkService.sendRequest(urlRequest: ProfileRouter.getPatient(id: id).createURLRequest(),
                                   successModel: Patient.self) { result in
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
    
    func getAddressAndPhone(id: Int, address: String, phone: String, completion: @escaping ((Patient?) -> Void)) {
        networkService.sendRequest(urlRequest: ProfileRouter.changeAddressAndPhone(id: id, phone: phone, address: address).createURLRequest(),
                                   successModel: Patient.self) { result in
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
    
    func addImage(id: Int, image: Data, completion: @escaping ((Patient?) -> Void)) {
        networkService.sendRequest(urlRequest: ProfileRouter.addImage(id: id, image: image).createURLRequest(),
                                   successModel: Patient.self) { result in
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
    
    func changeImage(id: Int, image: Data, completion: @escaping ((Patient?) -> Void)) {
        networkService.sendRequest(urlRequest: ProfileRouter.changeImage(id: id, image: image).createURLRequest(),
                                   successModel: Patient.self) { result in
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
