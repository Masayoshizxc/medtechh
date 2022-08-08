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
    func getNotifications(completion: @escaping ((SuccessFailure) -> Void))
    
    var model: [WeekModel]? {get set}
    var notifications: [Notifications]? { get set }
}

class HomeViewModel: HomeViewModelProtocol {
    
    var model: [WeekModel]? = [WeekModel]()
    var notifications: [Notifications]?

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
    
    func getNotifications(completion: @escaping ((SuccessFailure) -> Void)) {
        let userId = UserDefaultsService.shared.getUserId()
        service.getNotifications(id: userId) { result in
            guard let result = result else {
                completion(.failure)
                return
            }
            self.notifications = result
            completion(.success)
        }
    }

}
