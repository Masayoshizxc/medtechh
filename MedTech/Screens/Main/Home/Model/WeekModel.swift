//
//  WeekModel.swift
//  MedTech
//
//  Created by Eldiiar on 12/7/22.
//

import Foundation

struct WeekModel : Codable {
    let id : Int?
    let week : Int?
    let header : String?
    let imageUrl : String?
    let fileDB : FileDB?
    let description : String?
    let dateCreated : String?
    let dateUpdated : String?
    let dateDeleted : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case week = "week"
        case header = "header"
        case imageUrl = "imageUrl"
        case fileDB = "fileDB"
        case description = "description"
        case dateCreated = "dateCreated"
        case dateUpdated = "dateUpdated"
        case dateDeleted = "dateDeleted"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        week = try values.decodeIfPresent(Int.self, forKey: .week)
        header = try values.decodeIfPresent(String.self, forKey: .header)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        fileDB = try values.decodeIfPresent(FileDB.self, forKey: .fileDB)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
        dateUpdated = try values.decodeIfPresent(String.self, forKey: .dateUpdated)
        dateDeleted = try values.decodeIfPresent(String.self, forKey: .dateDeleted)
    }

}


struct FileDB : Codable {
    let id : Int?
    let name : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
