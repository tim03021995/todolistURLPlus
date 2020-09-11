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
    let status:Bool
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
    var taskData: [TaskDetails]?

    enum CodingKeys: String, CodingKey {
        case status
        case taskData = "task_data"
    }
}

struct TaskDetails: Codable {
    let id: Int
    let item: String
    let status: Int
    let createUser:String
    let updateUser: String
    let description:String?
//    let tag: ?
//    let image: ?
    let cardID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, item, status ,description
        case createUser = "create_user"
        case updateUser = "update_user"
//        case tag, image
        case cardID = "card_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

//MARK:- Card 資料結構

struct CardResponse: Codable {
    let status: Bool
    let cardData: CardData

    enum CodingKeys: String, CodingKey {
        case status
        case cardData = "card_data"
    }
}

struct CardData: Codable {
    let id: Int
    let username, email: String
//    let image: JSONNull?
    let createdAt, updatedAt: String
    let showCards: [ShowCard]

    enum CodingKeys: String, CodingKey {
        case id, username, email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case showCards = "show_cards"
    }
}

struct ShowCard: Codable {
    let id: Int
    let cardName, createUser, createdAt, updatedAt: String
    let pivot: Pivot
    let showTasks: [ShowTask]

    enum CodingKeys: String, CodingKey {
        case id
        case cardName = "card_name"
        case createUser = "create_user"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pivot
        case showTasks = "show_tasks"
    }
}

struct Pivot: Codable {
    let usersID, cardID: Int

    enum CodingKeys: String, CodingKey {
        case usersID = "users_id"
        case cardID = "card_id"
    }
}

struct ShowTask: Codable {
    let id: Int
    let item: String
    let status: Int
    let createUser, updateUser: String
    let description:String?
    let cardID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, item, status
        case createUser = "create_user"
        case updateUser = "update_user"
        case description = "description"
        case cardID = "card_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
