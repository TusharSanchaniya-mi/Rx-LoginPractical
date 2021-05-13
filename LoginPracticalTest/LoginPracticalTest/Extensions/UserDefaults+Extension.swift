//
//  UserDefaults+Extension.swift
//  LoginPracticalTest
//
//  Created by Mac-00014 on 29/04/21.
//

import Foundation



extension UserDefaults {
    
    var userModel : UserModel? {
        get {
            guard let userDict = UserDefaults.standard.value(forKey: "user") as? [String:Any] else { return nil }
            return UserModel(userDict)
        }
        set {
            UserDefaults.standard.setValue(newValue?.convertToDict, forKey: "user")
        }
    }
    
}
