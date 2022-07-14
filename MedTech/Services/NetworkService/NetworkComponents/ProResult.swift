//
//  ProResult.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 12/3/21.
//

import Foundation

enum ProResult<Success> {
    case success(Success)
    //case successEmpty(String)
    case badRequest(FailureModel)
    case unauthorized(String)
    //case forbidden(FailureModel, String)
    case notFound(FailureModel)
    //case methodNotAllowed(FailureModel, String)
    //case gone(FailureModel)
    //case unsupportedMediaType(FailureModel, String)
    //case internalServerError(FailureModel)
    //case notImplemented(FailureModel)
    //case serviceUnavailable(FailureModel, String)
    case failure(String)
}
