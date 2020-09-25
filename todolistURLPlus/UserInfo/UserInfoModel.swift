//
//  UserInfoModel.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/24.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation
class UserInfoModelManager{
    static func getUserData(email:String,complection:@escaping (UserData)->Void){
        let headers = ["userToken":UserToken.shared.userToken]
        let parameters = makeParameters(email)
        print(parameters)
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .GET, parameters: parameters, headers: headers)
        NetworkManager.sendRequest(with: request.send()) { (result:Result<GetUserResponse,NetworkError>) in
            switch result {
            case .success(let data):
                let userData = data.userData
                print("get user Data success")
                complection(userData)
            case .failure(let err):
                print(err)
            }
        }
    }
   private static func makeParameters(_ email:String)->[String:String]{
        var parameters:[String:String] = [:]
            parameters["email"] = email
        print(parameters)
        return parameters
    }
}
