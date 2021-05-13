//
//  String+Extension.swift
//  LoginPracticalTest
//
//  Created by Mac-00014 on 29/04/21.
//

import Foundation




extension String {
    
    func validateField(_ validationtype: ValidationType) -> Bool {
        
        if validationtype.rawValue == ValidationType.password.rawValue && self.contains(" ") {
            return false
        }
        
        let validateResult = NSPredicate(format:"SELF MATCHES %@", validationtype.rawValue)
        return validateResult.evaluate(with: self)
    }
}
