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
            return baseURL + endpoint.rawValue + "/{\(id)}"
        } else {
            return baseURL + endpoint.rawValue
        }
    }
    //    let contentType:ContentType

    let method: HTTPMethod
    
    ///body要放的東西
    var parameters: [String : Any]?
    
    ///headers要放的東西
    var headers : [String:String]?
    
    ///如果有要帶 ID 的話
    var id : Int?
    
    ///包裝request
    func send()-> URLRequest{
        
        
        let url = URL(string: self.urlString)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        
        request.addValue(ContentType.json.rawValue, forHTTPHeaderField: "Content-Type")
        
        if let parameters = parameters{
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        }
        
        if let headers = headers{
            request.allHTTPHeaderFields = headers
        }
        
        return request
    }
    
    func taskRequest ()-> URLRequest{
        let url = URL(string: self.urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue(ContentType.json.rawValue, forHTTPHeaderField: "Content-Type")
        
        if let headers = headers{
            request.allHTTPHeaderFields = headers
        }
        
        
        return request
    }
    
    
    
}


struct NetworkManager {
    
    func sendRequest<T:Codable>(with request: URLRequest, completion: @escaping (Result<T,NetworkError>) -> Void){
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async{
                if error != nil {
                    completion(.failure(.invalidURL))
                }
                //
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.errorResponse))
                    return
                }
                switch response.statusCode {
                case 200 ... 299:
                    print("Successs" , "Status Code:\(response.statusCode)")
                case 400:
                    completion(.failure(.errorResponse))
                default:
                    completion(.failure(.errorResponse))
                }
                //
                guard let data = data else{
                    completion(.failure(.invalidData))
                    return
                }
                
                do{
                    let decorder = JSONDecoder()
                    let decotedData = try decorder.decode(T.self, from: data)
                    completion(.success(decotedData))
                }catch{
                    print(error)
                    completion(.failure(.decodeError))
                }
                
            }
        }
        task.resume()
        
    }
}
