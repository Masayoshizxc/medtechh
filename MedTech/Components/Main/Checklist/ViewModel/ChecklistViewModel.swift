//
//  ChecklistViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 2/8/22.
//

import Foundation

protocol ChecklistViewModelProtocol {
    func getChecklists(completion: @escaping ((SuccessFailure) -> Void))
    func getAnswers(id: Int, completion: @escaping ((SuccessFailure?) -> Void))
    var model: [ChecklistModel] { get set }
    var checklist: [Checklist] { get set }
    var answers: [Answers]? { get set }
}

class ChecklistViewModel: ChecklistViewModelProtocol {

    var answers: [Answers]?
    var model = [ChecklistModel]()
    var checklist = [Checklist]()
    var appointments = ["Первичный осмотр -", "Второй осмотр -", "Третий осмотр -", "Четвертый осмотр -", "Пятый осмотр -",
                        "Шестой осмотр -", "Седьмой осмотр -", "Восьмой осмотр -", "Девятый осмотр -", "Десятый осмотр -"]
    
    private let service: ChecklistServiceProtocol
    private let userDefaults = UserDefaultsService()
    
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
            self.checklist.removeAll()
            for i in 0..<self.model.count {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "ru")
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateDate = dateFormatter.date(from: self.model[i].patientVisitDTO!.dateVisit!)
                dateFormatter.dateFormat = "d MMMM yyyy"
                let dateStr = dateFormatter.string(from: dateDate!)
                //let dateVisit = self.model[i].patientVisitDTO!.dateVisit
                self.checklist.append(Checklist(first: self.appointments[i], second: dateStr))
            }
            completion(.success)
        }
    }
    
    func getAnswers(id: Int, completion: @escaping ((SuccessFailure?) -> Void)) {
        service.getAnswers(id: id) { result in
            guard let result = result else {
                completion(.failure)
                return
            }
            DispatchQueue.global(qos: .utility).async {
                self.answers = result
                completion(.success)
            }
        }
    }
}
