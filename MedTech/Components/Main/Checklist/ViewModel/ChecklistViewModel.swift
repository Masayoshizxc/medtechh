//
//  ChecklistViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 2/8/22.
//

import Foundation

protocol ChecklistViewModelProtocol {
    func getChecklists(completion: @escaping ((SuccessFailure) -> Void))
    func getAnswers(id: Int, completion: @escaping (([Answers]?) -> Void))
    var model: [ChecklistModel] { get set }
}

class ChecklistViewModel: ChecklistViewModelProtocol {
    
    private let service: ChecklistServiceProtocol
    private let userDefaults = UserDefaultsService()
    var model = [ChecklistModel]()
    
    init(vm: ChecklistServiceProtocol = ChecklistService()) {
        service = vm
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getChecklists(completion: @escaping ((SuccessFailure) -> Void)) {
        let userId = userDefaults.getUserId()
        service.getChecklists(id: userId) { result in
            guard let result = result else {
                completion(.failure)
                return
            }
            self.model = result
            completion(.success)
        }
    }
    
    func getAnswers(id: Int, completion: @escaping (([Answers]?) -> Void)) {
        service.getAnswers(id: id) { result in
            completion(result)
        }
    }
}
