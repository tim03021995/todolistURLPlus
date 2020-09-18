//
//  UserResponse.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/18.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation
//MARK:- GET USER

///GET USER
struct GetUserResponse: Codable {
    let status: Bool
    let userData: UserData

    enum CodingKeys: String, CodingKey {
        case status
        case userData = "user_data"
    }
}

struct UserData: Codable {
    let id: String
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
///PUT USER or DELETE USER
struct PutOrDeleteUserResponse: Codable{
    let status: Bool
}

class Api {
    
    func getUser(){
        let header = ["userToken":UserToken.shared.userToken]
        
        var request = HTTPRequest(endpoint: .user, contentType: .json, method: .GET, headers: header)
        
        NetworkManager().sendRequest(with: request.send()) { (result:Result<GetUserResponse,NetworkError>) in
            
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




