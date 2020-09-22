//
//  UserResponse.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/18.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation
//MARK:- GET USER

///GET user (列出 user data)
struct GetUserResponse: Codable {
    let status: Bool
    let userData: UserData

    enum CodingKeys: String, CodingKey {
        case status
        case userData = "user_data"
    }
}

struct UserData: Codable {
    let id :Int
    let username:String
    let email:String
    let image:String?
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


//MARK:- PUT USER
///PUT user (更新 user name、password)
struct PutUserResponse: Codable{
    let status: Bool
}


//MARK:- POST USER Image
///POST user/image (新增 user 頭像)
struct PostUserImageResponse {
    let status: Bool
}


//MARK:- DELETE USER
///DELETE user/image (刪除 user 頭像)
struct DeleteUserResponse{
    let status: Bool
}

class Api {
    
    func getUser(){
        let header = ["userToken":UserToken.shared.userToken]
        
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .GET, headers: header)
        
        NetworkManager.sendRequest(with: request.send()) { (result:Result<GetUserResponse,NetworkError>) in
            
            switch result {
                
            case .success(let decodeData):
                print(decodeData.userData.email)
                print(decodeData)
            case .failure(let err):
                print(err.description)
            }
        }
        
         
    }
    
}




