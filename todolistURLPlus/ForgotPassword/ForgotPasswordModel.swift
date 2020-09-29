//
//  ForgotPasswordModel.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/29.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation
class ForgotPasswordModel{
    static func updateUserPassword(_ compeletion:@escaping ()->Void){
        let header = ["userToken":UserToken.shared.userToken]
        let password = UserDataManager.shared.email
        let parameters = makeParameters(nil, password)
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .PUT, parameters: parameters, headers: header)
        NetworkManager.sendRequest(with: request.send()) { (result:Result<PutUserResponse,NetworkError>) in
            switch result {
            case .success( _):
                print("update success")
            case .failure(let err):
                print("update error")
                print(err.description)
                print("錯誤訊息：\(err.errMessage)")
            }
            compeletion()
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
