//
//  TimeModel.swift
//  MedTech
//
//  Created by Eldiiar on 14/7/22.
//

import Foundation

struct TimeModel : Codable {
    let id : Int?
    let weekday : Int?
    let scheduleStartTime : String?
    let scheduleEndTime : String?
    let dateCreated : String?
    let dateUpdated : String?
    let dateDeleted : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case weekday = "weekday"
        case scheduleStartTime = "scheduleStartTime"
        case scheduleEndTime = "scheduleEndTime"
        case dateCreated = "dateCreated"
        case dateUpdated = "dateUpdated"
        case dateDeleted = "dateDeleted"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        weekday = try values.decodeIfPresent(Int.self, forKey: .weekday)
        scheduleStartTime = try values.decodeIfPresent(String.self, forKey: .scheduleStartTime)
        scheduleEndTime = try values.decodeIfPresent(String.self, forKey: .scheduleEndTime)
        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
        dateUpdated = try values.decodeIfPresent(String.self, forKey: .dateUpdated)
        dateDeleted = try values.decodeIfPresent(String.self, forKey: .dateDeleted)
    }

}
