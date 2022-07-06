//
//  UserDefaultsService.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 12/3/21.
//
import UIKit
import Foundation

class UserDefaultsService {
    
    enum Keys: String {
        case Authorization
        case phone_number
        case name
        case UID
        case FMC
    }
    
    enum Token: String {
        case access
        case refresh
    }
    
    enum Authority: String {
        case authority
    }
    
    enum CreateUser: String {
        case user_information
        case id
        case email
        case phone_number
        case name
        case date_of_birth
        case bonuses
    }
    
    private enum Authentification: String {
        case email
        case password
        case isSignedIn
    }
    
    private let storage: UserDefaults
    
    required init(storage: UserDefaults = UserDefaults.standard) {
        self.storage = storage
    }
    
    func getToken() -> String? {
        storage.value(forKey: Keys.Authorization.rawValue) as? String
    }
    func getKey(key: Keys) -> String {
        return key.rawValue
    }
    func save(token: String?) {
        if let token = token {
            storage.setValue("Bearer " + token, forKey: Keys.Authorization.rawValue)
        } else {
            storage.setValue(nil, forKey: Keys.Authorization.rawValue)
        }
    }
    func saveAccessToken(name: String?) {
        storage.setValue(name, forKey: Token.access.rawValue)
    }
    func saveRefreshToken(name: String?) {
        storage.setValue(name, forKey: Token.refresh.rawValue)
    }
    func saveUserUID(name: String?) {
        storage.setValue(name, forKey: Keys.UID.rawValue)
    }
    func saveUserFMC(name: String?) {
        storage.setValue(name, forKey: Keys.FMC.rawValue)
    }
    func savePhoneNumber(phoneNumber: String?) {
        storage.setValue(phoneNumber, forKey: Keys.phone_number.rawValue)
    }
    func saveUser(name: String?) {
        storage.setValue(name, forKey: Keys.name.rawValue)
    }
    func getByKey(key: Keys) -> String {
        return storage.value(forKey: key.rawValue) as? String ?? ""
    }
    func getByKey(key: Token) -> String {
        return storage.value(forKey: key.rawValue) as? String ?? ""
    }
    func saveCreateUser(value: String, key: CreateUser) {
        storage.setValue(value, forKey: key.rawValue)
    }
    func getCreatedUserValue(byKey: CreateUser) -> String {
        return storage.value(forKey: byKey.rawValue) as? String ?? "0"
    }
//    func saveCity(isBishkek: Bool) {
//        storage.setValue(isBishkek, forKey: Keys.city.rawValue)
//    }
    
    func saveAuthority(isAdmid: Bool) {
        storage.setValue(isAdmid, forKey: Authority.authority.rawValue)
    }
    func saveAuth(email: String, password: String) {
        storage.setValue(email, forKey: Authentification.email.rawValue)
        storage.setValue(password, forKey: Authentification.password.rawValue)
    }
    
    func isSignedIn(signedIn: Bool) {
        storage.setValue(signedIn, forKey: Authentification.isSignedIn.rawValue)
    }
    
    func didSignedIn() -> Bool {
        return storage.value(forKey: Authentification.isSignedIn.rawValue) as? Bool ?? false
    }
    
    func isHaveToken() -> Bool {
        if let _ = storage.value(forKey: Keys.Authorization.rawValue) as? String {
            return true
        }
        return false
    }
    
//    func saveUser(model: Data) {
//        storage.setValue(model, forKey: CreateUser.user_information.rawValue)
//    }
//
//    func getUser() -> Data {
//        return storage.value(forKey: CreateUser.user_information.rawValue) as! Data
//    }
    
    func saveUserId(id: Int) {
        storage.setValue(id, forKey: CreateUser.id.rawValue)
    }
    
    func getUserId() -> Int {
        return storage.value(forKey: CreateUser.id.rawValue) as! Int
    }
}
