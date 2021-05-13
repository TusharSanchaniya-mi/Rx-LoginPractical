//
//  Constants.swift
//  LoginPracticalTest
//
//  Created by Mac-00014 on 29/04/21.
//

import Foundation




struct LoginErrorMsg {
    static let emailError : String = "This is not valid email."
    static let passwordError : String = "Password should contains 1 Uppercase, 1 Lowercase and 1 Numberic value"
}


enum ValidationType: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case password = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,16}$"
}
