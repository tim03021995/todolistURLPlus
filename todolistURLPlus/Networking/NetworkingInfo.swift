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
    
    #warning("錯誤訊息可以都寫在這 分不同properties")
    var description:String{
        switch self{
            
        case .invalidURL: return "Something's wrong with URL"
            
        case .errorResponse: return "Wrong EMail or Password"
            
        case .invalidData: return "No Data"
            
        case .decodeError: return "Decode failure"
            
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
