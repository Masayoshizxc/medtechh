//
//  NotificationsRouter.swift
//  MedTech
//
//  Created by Eldiiar on 8/8/22.
//

import Foundation

enum NotificationsRouter: BaseRouter {
    case getNotifications(id: Int)

    var path: String {
        switch self {
        case let .getNotifications(id):
            return "/api/v1/patient/\(id)/notifications"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getNotifications:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getNotifications:
            return .GET
        }
    }

    var httpBody: Data? {
        switch self {
        case .getNotifications:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getNotifications:
            return nil
        }
    }
}
