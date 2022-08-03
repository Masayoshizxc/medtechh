//
//  ChecklistRouter.swift
//  MedTech
//
//  Created by Eldiiar on 2/8/22.
//

import Foundation

enum ChecklistRouter: BaseRouter {
    case getChecklists(id: Int)
    case getAnswers(id: Int)

    var path: String {
        switch self {
        case let .getChecklists(id):
            return "/api/v1/patients/\(id)/checklists"
        case let .getAnswers(id):
            return "/api/v1/checklists/\(id)/answers"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getChecklists:
            return nil
        case .getAnswers:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getChecklists:
            return .GET
        case .getAnswers:
            return .GET
        }
    }

    var httpBody: Data? {
        switch self {
        case .getChecklists:
            return nil
        case .getAnswers:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getChecklists:
            return nil
        case .getAnswers:
            return nil
        }
    }
}
