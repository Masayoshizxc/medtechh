//
//  BabyDevelopmentRouter.swift
//  MedTech
//
//  Created by Eldiiar on 12/7/22.
//

import Foundation

enum BabyDevelopmentRouter: BaseRouter {
    case getWeek(week: String)
    case getAllWeeks
    
    var path: String {
        switch self {
        case let .getWeek(week):
            return "/api/v1/weeks-of-baby-development/week/\(week)"
        case .getAllWeeks:
            return "/api/v1/weeks/all"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case.getWeek:
            return nil
        case .getAllWeeks:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getWeek:
            return .GET
        case .getAllWeeks:
            return .GET
        }
    }

    var httpBody: Data? {
        switch self {
        case .getWeek:
            return nil
        case .getAllWeeks:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getWeek:
            return nil
        case .getAllWeeks:
            return nil
        }
    }
}
