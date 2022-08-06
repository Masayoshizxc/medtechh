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
    func postAppointments(date: String, visitTime: String, completion: @escaping ((PatientVisitDTO?) -> Void))
    func getReservedDates(date: String, completion: @escaping ((ReservedDates?) -> Void))
    func getLastVisit(id: Int, completion: @escaping ((PatientVisitDTO?) -> Void))
    var timeModel: [TimeModel]? { get set }
    var patientVisit: PatientVisitDTO? { get set }
    var nonFreeTimes: [PatientVisitDTO]? { get set }
}

class AppointmentViewModel: AppointmentViewModelProtocol {
    
    var timeModel: [TimeModel]? = [TimeModel]()
    var patientVisit: PatientVisitDTO?
    var nonFreeTimes: [PatientVisitDTO]? = [PatientVisitDTO]()
    
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
            if result != nil {
                self.patientVisit = result
                completion(.success)
            } else {
                completion(.failure)
            }
            
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
        service.getNonFreeTimes(date: date) { result in
            if result != nil {
                self.nonFreeTimes = result
                completion(.success)
            } else {
                completion(.failure)
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
    func postAppointments(date: String, visitTime: String, completion: @escaping ((PatientVisitDTO?) -> Void)) {
        let doctorId = userDefaults.getDoctorId()
        let userId = userDefaults.getUserId()
        service.postAppointments(date: date, doctorId: doctorId!, patientId: userId, visitTime: visitTime) { result in
            completion(result)
        }
    }
    
    func getReservedDates(date: String, completion: @escaping ((ReservedDates?) -> Void)) {
        let doctorId = userDefaults.getDoctorId()
        service.getReservedDates(doctorId: doctorId!, date: date) { result in
            completion(result)
        }
    }
    
    func getLastVisit(id: Int, completion: @escaping ((PatientVisitDTO?) -> Void)) {
        service.getLastVisit(id: id) { result in
            completion(result)
        }
    }
}
