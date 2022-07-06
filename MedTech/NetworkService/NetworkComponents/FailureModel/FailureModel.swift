//
//  FailureModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 12/3/21.
//

import Foundation

struct FailureModel : Codable {
    let statusCode : Int?
    let timestamp : String?
    let message : String?
    let errors : [String]?

    enum CodingKeys: String, CodingKey {

        case statusCode = "statusCode"
        case timestamp = "timestamp"
        case message = "message"
        case errors = "errors"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        errors = try values.decodeIfPresent([String].self, forKey: .errors)
    }

}

