//
//  AppointmentsRouter.swift
//  MedTech
//
//  Created by Eldiiar on 14/7/22.
//

import Foundation

enum AppointmentsRouter: BaseRouter {
    case getVisit(id: Int, date: String)
    case getFreeTimes(doctorId: Int, weekDay: String)
    case getNonFreeTimes(date: String)
    case getDoctorId(id: Int)
    case postAppointments(date: String, doctorId: Int, patientId: Int, visitTime: String)
    
    var path: String {
        switch self {
        case let .getVisit(id, _):
            return "/api/v1/patients/\(id)/patient_visits/date"
        case let .getFreeTimes(doctorId, _):
            return "/api/v1/doctors/\(doctorId)/doctor_schedules"
        case .getNonFreeTimes:
            return "/api/v1/patient_visits/date"
        case let .getDoctorId(id):
            return "/api/v1/patients/\(id)/doctor"
        case .postAppointments:
            return "/api/v1/patient_visits"
        }
        
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case let .getVisit(_, date):
            return [URLQueryItem(name: "date", value: date)]
        case let .getFreeTimes(_, weekDay):
            return [URLQueryItem(name: "weekday", value: weekDay)]
        case let .getNonFreeTimes(date):
            return [URLQueryItem(name: "date", value: date)]
        case .getDoctorId:
            return nil
        case let .postAppointments(date, doctorId, patientId, visitTime):
            return [
                URLQueryItem(name: "dateVisit", value: date),
                URLQueryItem(name: "doctorId", value: String(doctorId)),
                URLQueryItem(name: "patientId", value: String(patientId)),
                URLQueryItem(name: "visitStartTime", value: visitTime),
            ]
        }
    }

    var method: HttpMethod {
        switch self {
        case .getVisit:
            return .GET
        case .getFreeTimes:
            return .GET
        case .getNonFreeTimes:
            return .GET
        case .getDoctorId:
            return .GET
        case .postAppointments:
            return .POST
        }
    }

    var httpBody: Data? {
        switch self {
        case .getVisit:
            return nil
        case .getFreeTimes:
            return nil
        case .getNonFreeTimes:
            return nil
        case .getDoctorId:
            return nil
        case .postAppointments:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getVisit:
            return nil
        case .getFreeTimes:
            return nil
        case .getNonFreeTimes:
            return nil
        case .getDoctorId:
            return nil
        case .postAppointments:
            return nil
        }
    }
}
