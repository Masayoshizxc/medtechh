//
//  NetworkErrors.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 12/3/21.
//

import Foundation

enum NetworkErrors: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    //case methodNotAllowed
    //case gone
    //case unsupportedMediaType
    //case internalServerError
    //case notImplemented
    //case serviceUnavailable
    case success
}
