//
//  WeekModel.swift
//  MedTech
//
//  Created by Eldiiar on 12/7/22.
//

import Foundation

struct WeekModel : Codable {
    let id : Int
    let weekday : Int
    var weeksOfBabyDevelopmentDTOS : [WeeksOfBabyDevelopmentDTOS]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case weekday = "weekday"
        case weeksOfBabyDevelopmentDTOS = "weeksOfBabyDevelopmentDTOS"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        weekday = try values.decode(Int.self, forKey: .weekday)
        weeksOfBabyDevelopmentDTOS = try values.decodeIfPresent([WeeksOfBabyDevelopmentDTOS].self, forKey: .weeksOfBabyDevelopmentDTOS)
    }

}

struct WeeksOfBabyDevelopmentDTOS : Codable {
    let id : Int
    let header : String?
    let imageUrl : String?
    let description : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case header = "header"
        case imageUrl = "imageUrl"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        header = try values.decodeIfPresent(String.self, forKey: .header)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}
