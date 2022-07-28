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
    let startOfPregnancy : String?
    let doctorDTO : DoctorDTO?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case userDTO = "userDTO"
        case startOfPregnancy = "startOfPregnancy"
        case doctorDTO = "doctorDTO"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        userDTO = try values.decodeIfPresent(UserDTO.self, forKey: .userDTO)
        startOfPregnancy = try values.decodeIfPresent(String.self, forKey: .startOfPregnancy)
        doctorDTO = try values.decodeIfPresent(DoctorDTO.self, forKey: .doctorDTO)
    }

}
