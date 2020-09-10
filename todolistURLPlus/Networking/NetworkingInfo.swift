//
//  NetworkingInfo.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation


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
        print(userToken)
    }
    mutating func clearToken(){
        userToken = ""
        print("Token cleared")
    }
    
}
