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

}
