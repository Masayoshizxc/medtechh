//
//  ProfileRouter.swift
//  MedTech
//
//  Created by Eldiiar on 16/7/22.
//

import Foundation
import UIKit

enum ProfileRouter: BaseRouter {
    case getPatient(id: Int)
    case addImage(id: Int, image: UIImage)
    case changeImage(id: Int, image: UIImage)
    case changeAddressAndPhone(id: Int, phone: String, address: String)

    var path: String {
        switch self {
        case let .getPatient(id):
            return "/api/v1/patients/\(id)"
        case let .addImage(id, image):
            return "/api/v1/patients/\(id)\(image)"
        case let .changeImage(id, image):
            return "/api/v1/patients/\(id)\(image)"
        case let .changeAddressAndPhone(id, _, _):
            return "/api/v1/patients/edit/\(id)"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getPatient:
            return nil
        case .addImage:
            return nil
        case .changeImage:
            return nil
        case .changeAddressAndPhone:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getPatient:
            return .GET
        case .addImage:
            return .GET
        case .changeImage:
            return .PUT
        case .changeAddressAndPhone:
            return .POST
        }
    }

    var httpBody: Data? {
        switch self {
        case .getPatient:
            return nil
        case .addImage:
            return nil
        case .changeImage:
            return nil
        case .changeAddressAndPhone:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getPatient:
            return nil
        case .addImage:
            return nil
        case .changeImage:
            return nil
        case .changeAddressAndPhone:
            return nil
        }
    }
}
