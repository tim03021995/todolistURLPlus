//
//  GroupResponse.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/22.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation

//MARK:- GET card users

///GET card users (查詢該card的所有使用者)
struct GetGroupResponse: Codable {
    let status: Bool
    let usersData: [UserData]
    
    enum CodingKeys: String, CodingKey {
        case status
        case usersData = "users_data"
    }
    
    
    struct UserData: Codable {
        let id: Int
        let username:String
        let email: String
        let image: String?
        let createdAt, updatedAt: String
        let pivot: Pivot
        
        enum CodingKeys: String, CodingKey {
            case id, username, email, image, pivot
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
    
    struct Pivot: Codable {
        let cardID, usersID: Int
        
        enum CodingKeys: String, CodingKey {
            case cardID = "card_id"
            case usersID = "users_id"
        }
    }
}

//MARK:- POST Group

///POST user into card (新增user進來card)
struct PostGroupResponse: Codable {
    let status: Bool
    let groupData: GroupData
    
    enum CodingKeys: String, CodingKey {
        case status
        case groupData = "group_data"
    }
    
    
    struct GroupData: Codable {
        let usersID: Int
        let cardID: String
        let updatedAt:String
        let createdAt: String
        let id: Int
        
        enum CodingKeys: String, CodingKey {
            case usersID = "users_id"
            case cardID = "card_id"
            case updatedAt = "updated_at"
            case createdAt = "created_at"
            case id
        }
    }
    
}

//MARK:- DELETE Group

///DELETE user form card (將user踢出card)
struct DeleteGroupResponse: Codable {
    let status: Bool
}
