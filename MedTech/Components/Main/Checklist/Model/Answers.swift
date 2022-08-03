//
//  Answers.swift
//  MedTech
//
//  Created by Eldiiar on 3/8/22.
//

import Foundation

struct Answers : Codable {
    let id : Int?
    let answerString : String?
    let answerStatus : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case answerString = "answerString"
        case answerStatus = "answerStatus"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        answerString = try values.decodeIfPresent(String.self, forKey: .answerString)
        answerStatus = try values.decodeIfPresent(Bool.self, forKey: .answerStatus)
    }

}
