//
//  NetworkingInfo.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation

//MARK:- decode的資料結構
struct ResponseStatus:Codable{
    var status:Bool
    var error:String?
    var loginData: LoginData?
    
    enum CodingKeys: String, CodingKey {
        case status
        case loginData = "login_data"
    }
}


struct LoginData : Codable {
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
    case card
    
}

enum ContentType:String{
    case json = "application/json"
    case urlForm = "application/x-www-form-urlencoded; charset=utf-8"
}


enum NetworkError:Error{
    case invalidURL
    case errorResponse
    case invalidData
    case decodeError
    
    var description:String{
        switch self{
            
        case .invalidURL: return "Something's wrong with URL"
            
        case .errorResponse: return "帳號或密碼錯誤"
            
        case .invalidData: return "3"
            
        case .decodeError: return "decode 失敗"
            
        }
    }
    
}
//MARK:- Token
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
