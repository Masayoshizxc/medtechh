//
//  AppoitmentViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 14/7/22.
//

import Foundation

protocol AppointmentViewModelProtocol {
    func getVisit(id: Int, date: String, completion: @escaping ((DoctorVisit?) -> Void))
    func getFreeTimes(doctorId: Int, weekday: String, completion: @escaping (([TimeModel]?) -> Void))
    func getNonFreeTimes(date: String, completion: @escaping (([DoctorVisit]?) -> Void))
    func getDoctorId(id: Int, completion: @escaping ((DoctorDTO?) -> Void))
    func postAppointments(date: String, doctorId: Int, patientId: Int, visitTime: String, completion: @escaping ((DoctorVisit?) -> Void))
}

class AppointmentViewModel: AppointmentViewModelProtocol {
    let networkService: NetworkService = NetworkService()
    
    func getVisit(id: Int, date: String, completion: @escaping ((DoctorVisit?) -> Void)) {
        networkService.sendRequest(urlRequest: AppointmentsRouter.getVisit(id: id, date: date).createURLRequest(),
                                   successModel: DoctorVisit.self) { result in
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
    
    func getFreeTimes(doctorId: Int, weekday: String, completion: @escaping (([TimeModel]?) -> Void)) {
        networkService.sendRequest(urlRequest: AppointmentsRouter.getFreeTimes(doctorId: doctorId, weekDay: weekday).createURLRequest(),
                                   successModel: [TimeModel].self) { result in
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
    
    func getNonFreeTimes(date: String, completion: @escaping (([DoctorVisit]?) -> Void)) {
        networkService.sendRequest(urlRequest: AppointmentsRouter.getNonFreeTimes(date: date).createURLRequest(),
                                   successModel: [DoctorVisit].self) { result in
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
    
    func getDoctorId(id: Int, completion: @escaping ((DoctorDTO?) -> Void)) {
        networkService.sendRequest(urlRequest: AppointmentsRouter.getDoctorId(id: id).createURLRequest(),
                                   successModel: DoctorDTO.self) { result in
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
    func postAppointments(date: String, doctorId: Int, patientId: Int, visitTime: String, completion: @escaping ((DoctorVisit?) -> Void)) {
        networkService.sendRequest(urlRequest: AppointmentsRouter.postAppointments(date: date,
                                                                                   doctorId: doctorId,
                                                                                   patientId: patientId,
                                                                                   visitTime: visitTime).createURLRequest(),
                                   successModel: DoctorVisit.self) { result in
            switch result {
            case .success(let model):
                completion(model)
            case .badRequest(let error):
                print(error)
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
