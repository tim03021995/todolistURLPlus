//
//  NetworkingInfo.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation

struct GetTokenSuccess:Codable{
    var message:String
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
        print(userToken)
    }
    mutating func clearToken(){
        userToken = ""
        print("Token cleared")
    }
    
}

enum NetworkError:Error{
    
    case invalidURL(String)
    case errorResponse
    case invalidData(String)
    case decodedError(String)
    
    var description:String{
        switch self{
            
        case .invalidURL(_): return "122333"
            
        case .errorResponse: return "帳號或密碼錯誤"
            
        case .invalidData(_): return ""
            
        case .decodedError(_): return ""
            
        }
    }
    
}
