import Foundation

struct SignIn : Codable {
    let type : String
    let token : String
    let refreshToken : String
    let id : Int
    let firstName : String
    let lastName : String
    let middleName : String
    let phoneNumber : String
    let email : String
    let pwdChangeRequired : Bool
    let roles : [String]

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case token = "token"
        case refreshToken = "refreshToken"
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case middleName = "middleName"
        case phoneNumber = "phoneNumber"
        case email = "email"
        case pwdChangeRequired = "pwdChangeRequired"
        case roles = "roles"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(String.self, forKey: .type)
        token = try values.decode(String.self, forKey: .token)
        refreshToken = try values.decode(String.self, forKey: .refreshToken)
        id = try values.decode(Int.self, forKey: .id)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        middleName = try values.decode(String.self, forKey: .middleName)
        phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
        email = try values.decode(String.self, forKey: .email)
        pwdChangeRequired = try values.decode(Bool.self, forKey: .pwdChangeRequired)
        roles = try values.decode([String].self, forKey: .roles)
    }

}
