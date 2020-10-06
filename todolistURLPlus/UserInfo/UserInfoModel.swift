//
//  UserInfoModel.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/24.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation
class UserInfoModelManager{
    static func getUserData(email:String,complection:@escaping (GetUserResponse.UserData)->Void){
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        let headers = ["userToken":token]
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .GET, headers: headers, mail: email).send()
        NetworkManager().sendRequest(with: request) { (res:Result<GetUserResponse,NetworkError>) in
            switch res {
                
            case .success(let data ):
                let userData = data.userData
                complection(userData)
            //TODO顯示
            case .failure(let err): print(err.description)
            //alert
            print(err.errMessage)
            }
        }
    }
}
