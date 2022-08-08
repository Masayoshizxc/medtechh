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
    case postAppointments(data: Data)
    case getReservedDates(doctorId: Int, startDate: String)
    case getLatestVisit(id: Int)
    
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
        case let .getReservedDates(doctorId, _):
            return "/api/v1/patient_visits/reserved-dates/\(doctorId)"
        case let .getLatestVisit(id):
            return "/api/v1/patient_visits/last-patient-visit/\(id)"
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
        case .postAppointments:
            return nil
        case let .getReservedDates(_, startDate):
            return [URLQueryItem(name: "startDate", value: startDate)]
        case .getLatestVisit:
            return nil
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
        case .getReservedDates:
            return .GET
        case .getLatestVisit:
            return .GET
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
        case let .postAppointments(data):
            return data
        case .getReservedDates:
            return nil
        case .getLatestVisit:
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
        case .getReservedDates:
            return nil
        case .getLatestVisit:
            return nil
        }
    }
}
