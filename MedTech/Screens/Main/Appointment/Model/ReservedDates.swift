//
//  ReservedDates.swift
//  MedTech
//
//  Created by Eldiiar on 19/7/22.
//

import Foundation

struct ReservedDates : Codable {
    let reservedDates : [String]?

    enum CodingKeys: String, CodingKey {

        case reservedDates = "reservedDates"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reservedDates = try values.decodeIfPresent([String].self, forKey: .reservedDates)
    }

}
