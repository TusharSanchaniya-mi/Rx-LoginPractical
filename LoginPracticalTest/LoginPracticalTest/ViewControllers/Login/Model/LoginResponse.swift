//
//  LoginResponse.swift
//  LoginPracticalTest
//
//  Created by Mac-00014 on 29/04/21.
//

import Foundation



class LoginResponse: Codable {
    
    let token : String?
    let error : String?
    
    init() {
        token = ""
        error = "Your email or password is incorrect."
    }
    
    /*
    var data: UserModel
    var resError: String
    var resCode: Int
    
    enum LoginCodingKeys: String, CodingKey {
        case data
        case resError = "error_message"
        case resCode = "result"
    }
    
    init() {
        data = UserModel()
        resError = "Something went wrong please try again."
        resCode = -1
    }*/
}



class UserModel: Codable {

    let iUserID: Int
    let vUserName: String
    let dCreatedAt: Date
    
    enum UserCodingKeys: String, CodingKey {
        case iUserID = "userId"
        case vUserName = "userName"
        case dCreatedAt = "created_at"
    }
    
    var convertToDict: [String:Any] {
        return [UserCodingKeys.iUserID.rawValue: self.iUserID,
                UserCodingKeys.vUserName.rawValue: self.vUserName,
                UserCodingKeys.dCreatedAt.rawValue: self.dCreatedAt]
    }
    
    init() {
        self.iUserID = 0
        self.vUserName = ""
        self.dCreatedAt = Date()
    }
    
    init(_ dictData: [String:Any]) {
        self.iUserID = dictData[UserCodingKeys.iUserID.rawValue] as? Int ?? 0
        self.vUserName = dictData[UserCodingKeys.vUserName.rawValue] as? String ?? ""
        self.dCreatedAt = dictData[UserCodingKeys.dCreatedAt.rawValue] as? Date ?? Date()
    }
    
}
