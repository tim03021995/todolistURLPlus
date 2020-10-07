//
//  NetworkError.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/15.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation


enum NetworkError:Error{
    case systemError
    case noResponse
    case noData
    case decodeError(struct: String)
    case responseError(error: ErrorData, statusCode: Int)
    case refreshToken
    case retry

    
    ///開發者用錯誤訊息 status code 或自定義錯誤訊息
    var description:String{
        switch self{
            
        case .systemError:  return "Something's wrong :\(self.localizedDescription)"
        case .noResponse:   return "No Response"
        case .noData:       return "No Data"
        case .decodeError(let structure):  return "Decode Error with \(structure)"
        case .responseError(error: _ , statusCode: let statusCode):
                            return "Response Error , Status Code:\(statusCode) "
        case .refreshToken: return "Refresh Token!"
            
        case .retry: return "Retry"
            
        }
    }
    ///response拿到的錯誤訊息
    var errMessage:String {
        switch self {
        case .responseError(error: let error, statusCode: _ ):
            return error.error
        default:
            return self.localizedDescription
        }
    }
    
    
}



struct ErrorData:Codable{
    let status : Bool
    let error : String
}



