//
//  AppoitmentViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 14/7/22.
//

import Foundation

protocol AppointmentViewModelProtocol {
    func getVisit(date: String, completion: @escaping ((SuccessFailure?) -> Void))
    func getFreeTimes(weekday: String, completion: @escaping ((SuccessFailure?) -> Void))
    func getNonFreeTimes(date: String, completion: @escaping ((SuccessFailure?) -> Void))
    func getDoctorId()
    func postAppointments(completion: @escaping ((SuccessFailure?) -> Void))
    func getReservedDates(date: String, completion: @escaping ((SuccessFailure?) -> Void))
    func getLastVisit(id: Int, completion: @escaping ((PatientVisitDTO?) -> Void))
    
    var timeModel: [TimeModel]? { get set }
    var patientVisit: PatientVisitDTO? { get set }
    var nonFreeTimes: [PatientVisitDTO]? { get set }
    var postAppointment: PatientVisitDTO? { get set }
    var reservedDates: ReservedDates? { get set }
    var freeTimes: [Time] { get set }
}

class AppointmentViewModel: AppointmentViewModelProtocol {
    
    var timeModel: [TimeModel]? = [TimeModel]()
    var patientVisit: PatientVisitDTO?
    var nonFreeTimes: [PatientVisitDTO]? = [PatientVisitDTO]()
    var postAppointment: PatientVisitDTO?
    var reservedDates: ReservedDates?
    var freeTimes = [Time]()
    
    private let service: AppointmentServiceProtocol
    private let userDefaults = UserDefaultsService()
    
    init(vm: AppointmentServiceProtocol = AppointmentService()) {
        service = vm
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getVisit(date: String, completion: @escaping ((SuccessFailure?) -> Void)) {
        let userId = userDefaults.getUserId()
        service.getVisit(id: userId, date: date) { result in
            guard let result = result else {
                completion(.failure)
                return
            }
            self.patientVisit = result
            completion(.success)
        
        }
    }
    
    func getFreeTimes(weekday: String, completion: @escaping ((SuccessFailure?) -> Void)) {
        let doctorId = userDefaults.getDoctorId()
        service.getFreeTimes(doctorId: doctorId!, weekday: weekday) { result in
            if result != nil {
                self.timeModel = result
                completion(.success)
            } else {
                completion(.failure)
            }
            
        }
    }
    
    func getNonFreeTimes(date: String, completion: @escaping ((SuccessFailure?) -> Void)) {
        service.getNonFreeTimes(date: date) { [weak self] result in
            guard let timeModel = self?.timeModel else {
                return
            }
            self?.freeTimes.removeAll()
            let nonFree = self?.nonFreeTimes
            for i in 0..<timeModel.count {
                let time = timeModel[i].scheduleStartTime
                if result == nil {
                    self?.nonFreeTimes = result
                    for j in 0..<nonFree!.count {
                        let nonFreeTime = nonFree![j].visitStartTime
                        if time != nonFreeTime {
                            let timee = time?.dropLast(3)
                            self?.freeTimes.append(Time(time: String(timee!)))
                        }
                    }
                    completion(.success)
                } else {
                    let timee = time?.dropLast(3)
                    self?.freeTimes.append(Time(time: String(timee!)))
                    completion(.failure)
                }
            }
        }
    }
    
    func getDoctorId() {
        let userId = userDefaults.getUserId()
        service.getDoctorId(id: userId) { result in
            if result != nil {
                let id = result?.userDTO.id
                self.userDefaults.saveDoctorId(id: id!)
            }
        }
    }
    func postAppointments(completion: @escaping ((SuccessFailure?) -> Void)) {
        let doctorId = userDefaults.getDoctorId()
        let userId = userDefaults.getUserId()
        let date = self.userDefaults.getDate()
        let time = self.userDefaults.getTime()
        guard let doctorId = doctorId else {
            completion(.failure)
            return
        }
        let visitStartTime: [String: Any] = [
            "minutes" : 13,
            "minute": 0,
            "nano": 0,
            "second": 0
            
        ]
        let data: [String : Any] = [
            "dateVisit" : date,
            "doctorId" : doctorId,
            "patentId" : userId,
            "visitStartTime" : visitStartTime
        ]
        let encodedData = (try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)) ?? nil
        guard let encodedData = encodedData else {
            completion(.failure)
            return
        }
        service.postAppointments(data: encodedData) { result in
            guard result != nil else {
                completion(.failure)
                return
            }
            self.postAppointment = result
            completion(.success)
        }
    }
    
    func getReservedDates(date: String, completion: @escaping ((SuccessFailure?) -> Void)) {
        let doctorId = userDefaults.getDoctorId()
        guard let doctorId = doctorId else {
            return
        }
        service.getReservedDates(doctorId: doctorId, date: date) { result in
            guard result != nil else {
                completion(.failure)
                return
            }
            self.reservedDates = result
            completion(.success)
        }
    }
    
    func getLastVisit(id: Int, completion: @escaping ((PatientVisitDTO?) -> Void)) {
        service.getLastVisit(id: id) { result in
            completion(result)
        }
    }
}
