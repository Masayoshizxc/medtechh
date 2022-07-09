//
//  ChangePasswordRouter.swift
//  MedTech
//
//  Created by Eldiiar on 5/7/22.
//

import Foundation

enum UserRouter: BaseRouter {
    case changePassword(id: Int, password: String)

    var path: String {
        switch self {
        case let .changePassword(id, _):
            return "/api/v1/users/\(id)/change-password"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case let .changePassword(_, password):
            return [URLQueryItem(name: "password", value: password)]
        }
    }

    var method: HttpMethod {
        switch self {
        case .changePassword:
            return .PUT
        }
    }

    var httpBody: Data? {
        switch self {
        case .changePassword:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .changePassword:
            return nil
        }
    }
}
