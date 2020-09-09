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
    var urlString:String { baseURL + endpoint.rawValue }
    let method: HTTPMethod
    let parameters: [String : Any]
    let contentType:ContentType
    
    ///包裝request
    func send()-> URLRequest{
        
        let url = URL(string: self.urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        request.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        
        return request
    }
    
}


struct NetworkManager {
    
    func sendRequest<T:Codable>(with request: URLRequest, completion: @escaping (Result<T,NetworkError>) -> Void){
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async{
                if let error = error {
                    completion(.failure(.invalidURL))
                }
                //
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.errorResponse))
                    return
                }
                switch response.statusCode {
                case 200 ... 299:
                    print("Successs" , "\(response.statusCode)")
//                case 400:
//                    completion(.failure(.errorResponse))
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
                    completion(.failure(.decodeError))
                }
                
            }
        }
        task.resume()
        
    }
}
