//
//  NotificationsRouter.swift
//  MedTech
//
//  Created by Eldiiar on 8/8/22.
//

import Foundation

enum NotificationsRouter: BaseRouter {
    case getNotifications(id: Int)
    case deleteById(id: Int)
    case deleteAll(userId: Int)

    var path: String {
        switch self {
        case let .getNotifications(id):
            return "/api/v1/patient/\(id)/notifications"
        case let .deleteById(id):
            return "/api/v1/notifications/\(id)"
        case let .deleteAll(id):
            return "/api/v1/patients/\(id)/notifications"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getNotifications:
            return nil
        case .deleteById:
            return nil
        case .deleteAll:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getNotifications:
            return .GET
        case .deleteById:
            return .DELETE
        case .deleteAll:
            return .DELETE
        }
    }

    var httpBody: Data? {
        switch self {
        case .getNotifications:
            return nil
        case .deleteById:
            return nil
        case .deleteAll:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getNotifications:
            return nil
        case .deleteById:
            return nil
        case .deleteAll:
            return nil
        }
    }
}
