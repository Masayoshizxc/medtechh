//
//  DoctorVisit.swift
//  MedTech
//
//  Created by Eldiiar on 14/7/22.
//

import Foundation

struct PatientVisitDTO : Codable {
    let id : Int?
    let doctorDTO : DoctorDTO?
    let dateVisit : String?
    let visitStartTime : String
    let visitEndTime : String
    let visitAddress : String?
    let visitStatus : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case doctorDTO = "doctorDTO"
        case dateVisit = "dateVisit"
        case visitStartTime = "visitStartTime"
        case visitEndTime = "visitEndTime"
        case visitAddress = "visitAddress"
        case visitStatus = "visitStatus"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        doctorDTO = try values.decodeIfPresent(DoctorDTO.self, forKey: .doctorDTO)
        dateVisit = try values.decodeIfPresent(String.self, forKey: .dateVisit)
        visitStartTime = try values.decode(String.self, forKey: .visitStartTime)
        visitEndTime = try values.decode(String.self, forKey: .visitEndTime)
        visitAddress = try values.decodeIfPresent(String.self, forKey: .visitAddress)
        visitStatus = try values.decodeIfPresent(String.self, forKey: .visitStatus)
    }

}


struct DoctorDTO : Codable {
    let id : Int?
    let userDTO : UserDTO
    let imageUrl : String?
    let fileDB : FileDB2?
    let profession : String?
    let education : String?
    let startWorkingDate : String?
    let workExperience : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case userDTO = "userDTO"
        case imageUrl = "imageUrl"
        case fileDB = "fileDB"
        case profession = "profession"
        case education = "education"
        case startWorkingDate = "startWorkingDate"
        case workExperience = "workExperience"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        userDTO = try values.decode(UserDTO.self, forKey: .userDTO)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        fileDB = try values.decodeIfPresent(FileDB2.self, forKey: .fileDB)
        profession = try values.decodeIfPresent(String.self, forKey: .profession)
        education = try values.decodeIfPresent(String.self, forKey: .education)
        startWorkingDate = try values.decodeIfPresent(String.self, forKey: .startWorkingDate)
        workExperience = try values.decodeIfPresent(Int.self, forKey: .workExperience)
    }

}

struct FileDB2: Codable {
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

struct UserDTO : Codable {
    let id : Int?
    let firstName : String
    let lastName : String
    let middleName : String
    let gender : String?
    let dob : String?
    let age : Int?
    let city : String?
    let address : String?
    let phoneNumber : String?
    let email : String?
    let roles : [String]?

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
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        middleName = try values.decode(String.self, forKey: .middleName)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        roles = try values.decodeIfPresent([String].self, forKey: .roles)
    }

}
