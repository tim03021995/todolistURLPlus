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
                if error != nil { completion(.failure(.systemError)) }
                
                 guard let response = response as? HTTPURLResponse else { completion(.failure(.noResponse))
                    return
                }
                guard let data = data else { completion(.failure(.noData))
                    return
                }
                self.responseHandler(data: data, response: response, completion: completion)
            }
        }
        task.resume()
    }
    
    private func responseHandler<T:Codable>
        (data:Data, response:HTTPURLResponse, completion:@escaping (Result<T,NetworkError>) -> Void){
        
        switch response.statusCode {
        case 200 ... 299:
            print("Successs" , "Status Code:\(response.statusCode)")
        case 400:
            completion(.failure(.responseError(statusCode: response.statusCode)))
        case 401:
            //refresh token
            break
        default:
            break
        }
        
        do{
            let decotedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decotedData))
        }catch{
            completion(.failure(.decodeError))
        }
    }

    
}

