//
//  HomeViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 12/7/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func getClinic()
    func getAllWeeks(completion: @escaping ((SuccessFailure) -> Void))
    var model: [WeekModel]? {get set}
}

class HomeViewModel: HomeViewModelProtocol {
    
    var model: [WeekModel]? = [WeekModel]()

    private let service: HomeServiceProtocol
    private let userDefaults = UserDefaultsService()
    
    init(vm: HomeServiceProtocol = HomeService()) {
        service = vm
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getClinic() {
        service.getClinic { result in
            guard result != nil else {
                return
            }
            self.userDefaults.saveEmergency(phone: (result?.emergencyPhoneNumber)!)
            self.userDefaults.saveReception(phone: (result?.receptionPhoneNumber)!)
        }
    }
    
    func getAllWeeks(completion: @escaping ((SuccessFailure) -> Void)) {
        service.getAllWeeks { result in
            if result != nil {
                self.model = result
                completion(.success)
            } else {
                completion(.failure)
            }
            
        }
    }

}
