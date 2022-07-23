//
//  ProfileRouter.swift
//  MedTech
//
//  Created by Eldiiar on 16/7/22.
//

import Foundation

enum ProfileRouter: BaseRouter {
    case getPatient(id: Int)

    var path: String {
        switch self {
        case let .getPatient(id):
            return "/api/v1/patients/\(id)"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getPatient:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getPatient:
            return .GET
        }
    }

    var httpBody: Data? {
        switch self {
        case .getPatient:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getPatient:
            return nil
        }
    }
}
