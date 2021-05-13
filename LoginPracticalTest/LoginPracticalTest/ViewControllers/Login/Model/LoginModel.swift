//
//  LoginModel.swift
//  LoginPracticalTest
//
//  Created by Mac-00014 on 29/04/21.
//

import Foundation

public struct LoginModel {
    var email : String
    var pasword : String
    
    var convertToDict : [String:Any] {
        return ["email": email, "password": pasword]
    }
}
