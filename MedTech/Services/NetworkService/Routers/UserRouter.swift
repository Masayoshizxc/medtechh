//
//  ChangePasswordRouter.swift
//  MedTech
//
//  Created by Eldiiar on 5/7/22.
//

import Foundation

enum UserRouter: BaseRouter {
    case changePassword(id: Int, oldPassword: String?, newPassword: String)

    var path: String {
        switch self {
        case let .changePassword(id, _, _):
            return "/api/v1/users/\(id)/change-password"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case let .changePassword(_, oldPassword, newPassword):
            if oldPassword != nil {
                return [
                    URLQueryItem(name: "oldPassword", value: oldPassword),
                    URLQueryItem(name: "newPassword", value: newPassword)
                ]
            } else {
                return [URLQueryItem(name: "newPassword", value: newPassword)]
            }
            
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
