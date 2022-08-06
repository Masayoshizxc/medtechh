//
//  ProfileViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import Foundation

enum SuccessFailure {
    case success
    case failure
}

protocol ProfileViewModelProtocol {
    func logOut(completion: @escaping ((SuccessFailure?) -> Void))
    func getPatient(completion: @escaping ((Patient?) -> Void))
    func getAddressAndPhone(id: Int, address: String, phone: String, completion: @escaping ((Patient?) -> Void))
    func addImage(id: Int, image: Data, boundary: String, completion: @escaping ((Patient?) -> Void))
    func changeImage(id: Int, image: Data, boundary: String, completion: @escaping ((Patient?) -> Void))
}

class ProfileViewModel: ProfileViewModelProtocol {
    let networkService: NetworkService = NetworkService()
    
    private let service: ProfileServiceProtocol
    private let userDefaults = UserDefaultsService()
    var model = [Patient]()
    
    init(vm: ProfileServiceProtocol = ProfileService()) {
        service = vm
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func logOut(completion: @escaping ((SuccessFailure?) -> Void)) {
        userDefaults.isSignedIn(signedIn: false)
        let userId = userDefaults.getUserId()
        let data: [String : Any] = [
            "userId" : userId
        ]
        let encodedData = (try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)) ?? nil
        service.logOut(data: encodedData!) { result in
            if result != nil {
                completion(.success)
            } else {
                completion(.failure)
            }
            
        }
        
    }
    
    func getPatient(completion: @escaping ((Patient?) -> Void)) {
        let userId = userDefaults.getUserId()
        
        service.getPatient(id: userId) { result in
            completion(result)
        }
    }
    
    func getAddressAndPhone(id: Int, address: String, phone: String, completion: @escaping ((Patient?) -> Void)) {
        service.getAddressAndPhone(id: id, address: address, phone: phone) { result in
            completion(result)
        }
    }
    
    func addImage(id: Int, image: Data, boundary: String, completion: @escaping ((Patient?) -> Void)) {
        service.addImage(id: id, image: image, boundary: boundary) { result in
            completion(result)
        }
    }
    
    func changeImage(id: Int, image: Data, boundary: String, completion: @escaping ((Patient?) -> Void)) {
        service.changeImage(id: id, image: image, boundary: boundary) { result in
            completion(result)
        }
    }
}
