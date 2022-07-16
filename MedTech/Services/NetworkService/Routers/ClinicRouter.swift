//
//  ClinicRouter.swift
//  MedTech
//
//  Created by Eldiiar on 16/7/22.
//

import Foundation

enum ClinicRouter: BaseRouter {
    case getClinic

    var path: String {
        switch self {
        case .getClinic:
            return "/api/v1/clinics/1"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getClinic:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getClinic:
            return .GET
        }
    }

    var httpBody: Data? {
        switch self {
        case .getClinic:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getClinic:
            return nil
        }
    }
}
