//
//  DecodeStruct.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/10.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation

//MARK:- 登入註冊的資料結構
struct LoginInReaponse:Codable{
    var status:Bool
    var error:String?
    var loginData: LoginData?
    
    enum CodingKeys: String, CodingKey {
        case status
        case error
        case loginData = "login_data"
    }
}

struct LoginData : Codable {
    var userToken:String
}

//MARK:- Task的資料結構

struct TaskReaponse: Codable {
    let status: Bool
    let taskData: [Task]?

    enum CodingKeys: String, CodingKey {
        case status
        case taskData = "task_data"
    }
}

struct Task: Codable {
    let id: Int
    let item: String
    let status: Int
    let createUser, updateUser: String
//    let taskDatumDescription, tag, image: nil
    let cardID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, item, status
        case createUser = "create_user"
        case updateUser = "update_user"
//        case taskDatumDescription = "description"
//        case tag, image
        case cardID = "card_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}
