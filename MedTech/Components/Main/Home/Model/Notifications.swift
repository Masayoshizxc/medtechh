//
//  Notifications.swift
//  MedTech
//
//  Created by Eldiiar on 8/8/22.
//

import Foundation

struct Notifications : Codable {
    let id : Int?
    let patient : Patient?
    let header : String?
    let message : String?
    let dateCreated : String?
    let read : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case patient = "patientDTO"
        case header = "header"
        case message = "message"
        case dateCreated = "dateCreated"
        case read = "read"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        patient = try values.decodeIfPresent(Patient.self, forKey: .patient)
        header = try values.decodeIfPresent(String.self, forKey: .header)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
        read = try values.decodeIfPresent(Bool.self, forKey: .read)
    }

}
