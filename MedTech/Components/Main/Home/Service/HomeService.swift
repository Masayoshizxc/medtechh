//
//  HomeService.swift
//  MedTech
//
//  Created by Eldiiar on 5/8/22.
//

import Foundation

protocol HomeServiceProtocol {
    func getClinic(completion: @escaping ((Clinic?) -> Void))
    func getAllWeeks(completion: @escaping (([WeekModel]?) -> Void))
    func getNotifications(id: Int, completion: @escaping (([Notifications]?) -> Void))
    func deleteAllNotifications(patientId: Int)
    func deleteNotificationsById(id: Int)
}

class HomeService: HomeServiceProtocol {
    let networkService: NetworkService = NetworkService()
    
    func getClinic(completion: @escaping ((Clinic?) -> Void)) {
        networkService.sendRequest(urlRequest: ClinicRouter.getClinic.createURLRequest(),
                                   successModel: Clinic.self) { result in
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
    
    func getAllWeeks(completion: @escaping (([WeekModel]?) -> Void)) {
        networkService.sendRequest(urlRequest: BabyDevelopmentRouter.getAllWeeks.createURLRequest(),
                                   successModel: [WeekModel].self) { result in
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
    
    func getNotifications(id: Int, completion: @escaping (([Notifications]?) -> Void)) {
        networkService.sendRequest(urlRequest: NotificationsRouter.getNotifications(id: id).createURLRequest(),
                                   successModel: [Notifications].self) { result in
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
    
    func deleteAllNotifications(patientId: Int) {
        networkService.sendRequest(urlRequest: NotificationsRouter.deleteAll(userId: patientId).createURLRequest(),
                                   successModel: [Notifications].self) { result in
            switch result {
            case .success(let model):
                print(model)
            case .badRequest(let error):
                debugPrint(#function, error)
            case .failure(let error):
                debugPrint(#function, error)
            case .unauthorized(let error):
                debugPrint(#function, error)
            case .notFound(let error):
                debugPrint(#function, error)
            }
        }
    }
    
    func deleteNotificationsById(id: Int) {
        networkService.sendRequest(urlRequest: NotificationsRouter.deleteById(id: id).createURLRequest(),
                                   successModel: [Notifications].self) { result in
            switch result {
            case .success(let model):
                print(model)
            case .badRequest(let error):
                debugPrint(#function, error)
            case .failure(let error):
                debugPrint(#function, error)
            case .unauthorized(let error):
                debugPrint(#function, error)
            case .notFound(let error):
                debugPrint(#function, error)
            }
        }
    }

}
