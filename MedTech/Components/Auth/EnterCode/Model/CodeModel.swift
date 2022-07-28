//
//  CodeModel.swift
//  MedTech
//
//  Created by Eldiiar on 8/7/22.
//

import Foundation

struct CodeModel : Codable {
    let id : Int?
    let firstName : String?
    let lastName : String?
    let middleName : String?
    let gender : String?
    let dob : String?
    let age : Int?
    let city : String?
    let address : String?
    let phoneNumber : String?
    let email : String?
    let roles : [String]?
    let dateCreated : String?
    let dateUpdated : String?
    let dateDeleted : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case middleName = "middleName"
        case gender = "gender"
        case dob = "dob"
        case age = "age"
        case city = "city"
        case address = "address"
        case phoneNumber = "phoneNumber"
        case email = "email"
        case roles = "roles"
        case dateCreated = "dateCreated"
        case dateUpdated = "dateUpdated"
        case dateDeleted = "dateDeleted"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        middleName = try values.decodeIfPresent(String.self, forKey: .middleName)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        roles = try values.decodeIfPresent([String].self, forKey: .roles)
        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
        dateUpdated = try values.decodeIfPresent(String.self, forKey: .dateUpdated)
        dateDeleted = try values.decodeIfPresent(String.self, forKey: .dateDeleted)
    }

}
