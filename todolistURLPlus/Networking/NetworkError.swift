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
    case decodeError
    case responseError(error: Errormessage, statusCode: Int)

    
    
    var description:String{
        switch self{
            
        case .systemError:  return self.localizedDescription
        case .noResponse:   return "No Response"
        case .noData:       return "No Data"
        case .decodeError:  return "Decode Error"
        case .responseError(error: _ , statusCode: let statusCode):
                            return "Response Error , Status Code:\(statusCode) "
            
        }
    }
    
    var errMessage:String {
        switch self {
            
        case .responseError(error: let error, statusCode: _ ):
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
