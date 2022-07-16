//
//  HomeViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 12/7/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func getWeek(week: String, completion: @escaping (([WeekModel]?) -> Void))
    func getClinic(completion: @escaping ((Clinic?) -> Void))
}

class HomeViewModel: HomeViewModelProtocol {
    let networkService: NetworkService = NetworkService()
    
    func getWeek(week: String, completion: @escaping (([WeekModel]?) -> Void)) {
        networkService.sendRequest(urlRequest: BabyDevelopmentRouter.getWeek(week: week).createURLRequest(),
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
