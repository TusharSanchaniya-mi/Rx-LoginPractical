//
//  AsyncAPIRouter.swift
//  LoginPracticalTest
//
//  Created by Mac-00014 on 29/04/21.
//

import Foundation
import Moya

enum AsyncAPIRouter {
    case loginAPI(LoginModel)
}


extension AsyncAPIRouter: TargetType {
    var baseURL: URL {
//        return URL(string: "http://imaginato.mocklab.io")!
        return URL(string: "https://www.google.in")!
    }
    
    var path: String {
        switch self {
        case .loginAPI:
            return "/login"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .loginAPI:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .loginAPI(let loginModel):
            return .requestParameters(parameters: loginModel.convertToDict, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
