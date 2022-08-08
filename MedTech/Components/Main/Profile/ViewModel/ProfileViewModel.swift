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
    func getPatient(completion: @escaping ((SuccessFailure?) -> Void))
    func getAddressAndPhone(address: String, phone: String, completion: @escaping ((SuccessFailure?) -> Void))
    func addImage(id: Int, image: Data, boundary: String, completion: @escaping ((Patient?) -> Void))
    func changeImage(id: Int, image: Data, boundary: String, completion: @escaping ((Patient?) -> Void))
    
    var patient: Patient? { get set }
}

class ProfileViewModel: ProfileViewModelProtocol {
    let networkService: NetworkService = NetworkService()
    
    private let service: ProfileServiceProtocol
    private let userDefaults = UserDefaultsService()
    var model = [Patient]()
    var patient: Patient?
    
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
    
    func getPatient(completion: @escaping ((SuccessFailure?) -> Void)) {
        let userId = userDefaults.getUserId()
        service.getPatient(id: userId) { result in
            guard let result = result else {
                completion(.failure)
                return
            }
            self.patient = result
            completion(.success)
        }
    }
    
    func getAddressAndPhone(address: String, phone: String, completion: @escaping ((SuccessFailure?) -> Void)) {
        let userId = userDefaults.getUserId()
        let data: [String : Any] = [
            "address" : address,
            "phoneNumber" : phone
        ]
        let encodedData = (try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)) ?? nil
        guard let encodedData = encodedData else {
            completion(.failure)
            return
        }
        service.getAddressAndPhone(id: userId, data: encodedData) { result in
            guard result != nil else {
                completion(.failure)
                return
            }
            completion(.success)
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
