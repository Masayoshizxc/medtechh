//
//  BabyDevelopmentRouter.swift
//  MedTech
//
//  Created by Eldiiar on 12/7/22.
//

import Foundation

enum BabyDevelopmentRouter: BaseRouter {
    case getAllWeeks
    
    var path: String {
        switch self {
        case .getAllWeeks:
            return "/api/v1/weeks/all"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getAllWeeks:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getAllWeeks:
            return .GET
        }
    }

    var httpBody: Data? {
        switch self {
        case .getAllWeeks:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getAllWeeks:
            return nil
        }
    }
}
