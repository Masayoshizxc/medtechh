//
//  ChecklistModel.swift
//  MedTech
//
//  Created by Eldiiar on 2/8/22.
//

import Foundation

struct ChecklistModel : Codable {
    let id : Int?
    let patientVisitDTO : PatientVisitDTO?
    let imageUrl : String?
    let ultReport : String?
    let drugList : String?
    let extraInfo : String?
    let conclusion : String?
    let pregnancyNumber : Int?
    let basic_questions : [Basic_questions]?
    let analyzes : [Analyzes]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case patientVisitDTO = "patientVisitDTO"
        case imageUrl = "imageUrl"
        case ultReport = "ultReport"
        case drugList = "drugList"
        case extraInfo = "extraInfo"
        case conclusion = "conclusion"
        case pregnancyNumber = "pregnancyNumber"
        case basic_questions = "basic_questions"
        case analyzes = "analyzes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        patientVisitDTO = try values.decodeIfPresent(PatientVisitDTO.self, forKey: .patientVisitDTO)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        ultReport = try values.decodeIfPresent(String.self, forKey: .ultReport)
        drugList = try values.decodeIfPresent(String.self, forKey: .drugList)
        extraInfo = try values.decodeIfPresent(String.self, forKey: .extraInfo)
        conclusion = try values.decodeIfPresent(String.self, forKey: .conclusion)
        pregnancyNumber = try values.decodeIfPresent(Int.self, forKey: .pregnancyNumber)
        basic_questions = try values.decodeIfPresent([Basic_questions].self, forKey: .basic_questions)
        analyzes = try values.decodeIfPresent([Analyzes].self, forKey: .analyzes)
    }

}

struct Analyzes : Codable {
    let id : Int?
    let analysisString : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case analysisString = "analysisString"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        analysisString = try values.decodeIfPresent(String.self, forKey: .analysisString)
    }

}

struct Basic_questions : Codable {
    let id : Int?
    let questionString : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case questionString = "questionString"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        questionString = try values.decodeIfPresent(String.self, forKey: .questionString)
    }

}
