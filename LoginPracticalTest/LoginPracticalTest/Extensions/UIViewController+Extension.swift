//
//  UIViewController+Extension.swift
//  LoginPracticalTest
//
//  Created by Mac-00014 on 29/04/21.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(_ strMsg : String) {
        let objAlertController = UIAlertController(title: "", message: strMsg, preferredStyle: .alert)
        let objCancelaction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        objAlertController.addAction(objCancelaction)
        self.present(objAlertController, animated: true, completion: nil)
    }
}
