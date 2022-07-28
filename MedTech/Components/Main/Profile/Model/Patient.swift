//
//  Patient.swift
//  MedTech
//
//  Created by Eldiiar on 16/7/22.
//

import Foundation

struct Patient : Codable {
    let id : Int?
    let userDTO : UserDTO?
    let doctorDTO : DoctorDTO?
    let startOfPregnancy : String?
    let pregnancyNumber : Int?
    let imageUrl : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case userDTO = "userDTO"
        case doctorDTO = "doctorDTO"
        case startOfPregnancy = "startOfPregnancy"
        case pregnancyNumber = "pregnancyNumber"
        case imageUrl = "imageUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        userDTO = try values.decodeIfPresent(UserDTO.self, forKey: .userDTO)
        doctorDTO = try values.decodeIfPresent(DoctorDTO.self, forKey: .doctorDTO)
        startOfPregnancy = try values.decodeIfPresent(String.self, forKey: .startOfPregnancy)
        pregnancyNumber = try values.decodeIfPresent(Int.self, forKey: .pregnancyNumber)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
    }

}
