//
//  ChecklistViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 2/8/22.
//

import Foundation

protocol ChecklistViewModelProtocol {
    func getChecklists(id: Int, completion: @escaping (([ChecklistModel]?) -> Void))
    func getAnswers(id: Int, completion: @escaping (([Answers]?) -> Void))
}

class ChecklistViewModel: ChecklistViewModelProtocol {
    let networkService: NetworkService = NetworkService()
    
    func getChecklists(id: Int, completion: @escaping (([ChecklistModel]?) -> Void)) {
        networkService.sendRequest(urlRequest: ChecklistRouter.getChecklists(id: id).createURLRequest(),
                                   successModel: [ChecklistModel].self) { result in
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
    
    func getAnswers(id: Int, completion: @escaping (([Answers]?) -> Void)) {
        networkService.sendRequest(urlRequest: ChecklistRouter.getAnswers(id: id).createURLRequest(),
                                   successModel: [Answers].self) { result in
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
