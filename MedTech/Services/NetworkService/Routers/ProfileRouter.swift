//
//  ProfileRouter.swift
//  MedTech
//
//  Created by Eldiiar on 16/7/22.
//

import Foundation

enum ProfileRouter: BaseRouter {
    case getPatient(id: Int)
    case addImage(id: Int, image: Data)
    case changeImage(id: Int, image: Data)
    case changeAddressAndPhone(id: Int, phone: String, address: String)

    var path: String {
        switch self {
        case let .getPatient(id):
            return "/api/v1/patients/\(id)"
        case let .addImage(id, _):
            return "/api/v1/patients/img/\(id)"
        case let .changeImage(id, _):
            return "/api/v1/patients/img/\(id)"
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
        case let .changeAddressAndPhone(_, phone, address):
            return [
                URLQueryItem(name: "address", value: address),
                URLQueryItem(name: "phoneNumber", value: phone)
            ]
        }
    }

    var method: HttpMethod {
        switch self {
        case .getPatient:
            return .GET
        case .addImage:
            return .POST
        case .changeImage:
            return .PUT
        case .changeAddressAndPhone:
            return .PUT
        }
    }

    var httpBody: Data? {
        switch self {
        case .getPatient:
            return nil
        case let .addImage(_, image):
            return image
        case let .changeImage(_, image):
            return image
        case .changeAddressAndPhone:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getPatient:
            return nil
        case .addImage:
            return [
                HttpHeader(field: "Content-Type", value: "multipart/form-data"),
                HttpHeader(field: "Content-Type", value: "image/jpeg")
            ]
        case .changeImage:
            return [HttpHeader(field: "Content-Type", value: "multipart/form-data")]
        case .changeAddressAndPhone:
            return nil
        }
    }
}
