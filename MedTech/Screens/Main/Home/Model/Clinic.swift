//
//  Clinic.swift
//  MedTech
//
//  Created by Eldiiar on 16/7/22.
//

import Foundation

struct Clinic : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let address : String?
    let emergencyPhoneNumber : String?
    let receptionPhoneNumber : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case address = "address"
        case emergencyPhoneNumber = "emergencyPhoneNumber"
        case receptionPhoneNumber = "receptionPhoneNumber"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        emergencyPhoneNumber = try values.decodeIfPresent(String.self, forKey: .emergencyPhoneNumber)
        receptionPhoneNumber = try values.decodeIfPresent(String.self, forKey: .receptionPhoneNumber)
    }

}
