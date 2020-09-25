//
//  Networking.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation


struct HTTPRequest {
    
    let baseURL = "http://35.185.131.56:8002/api/"
    let endpoint:Endpoint
    var urlString:String {
        if let id = id {
            return baseURL + endpoint.rawValue + "/\(id)"
        }else if let mail = mail{
            return baseURL + endpoint.rawValue + "/\(mail)"
        } else {
            return baseURL + endpoint.rawValue
        }
    }
    let contentType:ContentType
    let method: HTTPMethod
    var parameters: [String : Any]?
    var headers : [String:String]?
    var id : Int?
    var mail: String?
    
    ///包裝request
    func send()-> URLRequest{
        
        let url = URL(string: self.urlString)
        var request = URLRequest(url: url!)
        
        request.httpMethod = method.rawValue
        
        request.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        if let headers = headers{
            request.allHTTPHeaderFields = headers
        }
        if let parameters = parameters{
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        }
        return request
    }
    
    func imageRequest(boundary: String, data: Data) -> URLRequest {
        let url = URL(string: self.urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        request.addValue(contentType.rawValue + "; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = data
        
        if let headers = headers{
            request.allHTTPHeaderFields = headers
        }
        
        
        return request
    }
    
    
}
