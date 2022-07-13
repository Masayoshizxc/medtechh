//
//  BabyDevelopmentRouter.swift
//  MedTech
//
//  Created by Eldiiar on 12/7/22.
//

import Foundation

enum BabyDevelopmentRouter: BaseRouter {
    case getWeek(week: String)
    
    var path: String {
        switch self {
        case let .getWeek(week):
            return "/api/v1/weeks-of-baby-development/week/\(week)"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case let .getWeek(week):
            return nil //[URLQueryItem(name: "week", value: week)]
        }
    }

    var method: HttpMethod {
        switch self {
        case .getWeek:
            return .GET
        }
    }

    var httpBody: Data? {
        switch self {
        case .getWeek:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getWeek:
            return nil
        }
    }
}
