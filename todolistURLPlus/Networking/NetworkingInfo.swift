//
//  NetworkingInfo.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation

struct ResponseStatus:Codable{
    var status:Bool
    var error:String?
    var data:Data?
}

struct Data : Codable {
    var userToken:String
}


enum HTTPMethod:String{
    
    case GET
    case POST
    case PUT
    case DELETE
}

enum Endpoint:String {
    
    case userToken
    case register
    case task
}

enum ContentType:String{
    case json = "application/json"
    case urlForm = "application/x-www-form-urlencoded; charset=utf-8"
}

struct UserToken {
    private(set) var userToken = ""
    private init(){}
    static var shared = UserToken()
    
    mutating func updateToken(by token: String){
        userToken = token
//        print(userToken)
    }
    mutating func clearToken(){
        userToken = ""
        print("Token cleared")
    }
    
}

enum NetworkError:Error{
    
    case invalidURL
    case errorResponse
    case invalidData
    case decodeError
    
    var description:String{
        switch self{
            
        case .invalidURL: return "1"
            
        case .errorResponse: return "帳號或密碼錯誤"
            
        case .invalidData: return "3"
            
        case .decodeError: return "decode 失敗"
            
        }
    }
    
}
