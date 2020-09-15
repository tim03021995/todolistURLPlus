//
//  Manager.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/15.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    func sendRequest<T:Codable>(with request: URLRequest, completion: @escaping (Result<T,NetworkError>) -> Void){
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async{
                if error != nil {
                    completion(.failure(.systemError))
                }
                //
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.noResponse))
                    return
                }
                switch response.statusCode {
                case 200 ... 299:
                    print("Successs" , "Status Code:\(response.statusCode)")
                case 400:
                    completion(.failure(.responseError(statusCode: response.statusCode)))
                default:
                    break
                }
                //
                guard let data = data else{
                    completion(.failure(.noData))
                    return
                }
                
                do{
                    let decorder = JSONDecoder()
                    let decotedData = try decorder.decode(T.self, from: data)
                    completion(.success(decotedData))
                }catch{
//                    print(error)
                    completion(.failure(.decodeError))
                }
                
            }
        }
        task.resume()
    }
}
