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
    case responseError(error: Errormessage, statusCode: Int)
    case noData
    case decodeError
    
    
    
    var description:String{
        switch self{
            
        case .systemError: return self.localizedDescription
        case .noResponse: return "No Response"
        case .responseError(error: let error, statusCode: let statusCode): return "Response Error , Status Code:\(statusCode) "
        case .noData: return "No Data"
        case .decodeError: return "Decode Error"
            
        }
    }
    
    var errMessage:String {
        switch self {

        case .responseError(error: let error, statusCode: let statusCode):
            return error.error
        default:
            return self.localizedDescription
        }
    }
    
}

struct Errormessage:Codable{
    let status : Bool
    let error : String
    
}
