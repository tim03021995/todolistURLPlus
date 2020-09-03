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
    case errorResponse(String)
    case invalidData(String)
    case decodedError(String)
    
    var description:String{
        switch self{
            
        case .invalidURL(_): return "122333"
            
        case .errorResponse(_): return ""
            
        case .invalidData(_): return ""
            
        case .decodedError(_): return ""
            
        }
    }
    
}
