//
//  ForgotPasswordModel.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/29.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation
class ModifyPasswordModel{
    static func updateUserPassword(password:String,_ compeletion:@escaping (Result<PutUserResponse,NetworkError>)->Void){
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        let header = ["userToken":token]
        let parameters = makeParameters(nil, password)
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .PUT, parameters: parameters, headers: header)
        NetworkManager().sendRequest(with: request.send()) { (result:Result<PutUserResponse,NetworkError>) in
            compeletion(result)
        }
    }
    private static func makeParameters(_ userName:String?,_ passWord:String?)->[String:Any]{
        var parameters:[String:Any] = [:]
        if let title = userName {
            parameters["username"] = title
        }
        if let description = passWord {
            parameters["password"] = description
        }
        print(parameters)
        return parameters
    }
}
