//
//  CardResponse.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/14.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation

//MARK:- GET Card 所有資料

struct GetAllCardResponse: Codable {
    let status: Bool
    let cardData: CardData?
    let error: String?
    
    
    enum CodingKeys: String, CodingKey {
        case status, error
        case cardData = "card_data"
    }
    
    struct CardData: Codable {
        let id: Int
        let username:String
        let email: String
        let image: String?
        let createdAt:String
        let updatedAt: String
        let showCards: [ShowCard] //全部的card
        
        enum CodingKeys: String, CodingKey {
            case id, username, email, image
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case showCards = "show_cards"
        }
    }
    
    struct ShowCard: Codable {
        let id: Int
        let cardName:String
        let createUser:String
        let createdAt:String
        let updatedAt: String
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
    
    
    struct ShowTask: Codable {
        let id: Int
        let title: String
        let status: Bool
        let createUser, updateUser: String
        let description:String?
        let cardID: Int
        let createdAt, updatedAt: String
        
        enum CodingKeys: String, CodingKey {
            case id, title, status
            case createUser = "create_user"
            case updateUser = "update_user"
            case description = "description"
            case cardID = "card_id"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
    
    
    struct Pivot: Codable {
        let usersID, cardID: Int
        
        enum CodingKeys: String, CodingKey {
            case usersID = "users_id"
            case cardID = "card_id"
        }
    }
}
//MARK:- POST  (新增card)


struct PostCardResponse: Codable {
    let status: Bool
    let cardData: CardData?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case status,error
        case cardData = "card_data"
    }
    
    
    struct CardData: Codable {
        let cardName: String
        let createUser: String
        let updatedAt: String
        let createdAt: String
        let id: Int
        
        enum CodingKeys: String, CodingKey {
            case cardName = "card_name"
            case createUser = "create_user"
            case updatedAt = "updated_at"
            case createdAt = "created_at"
            case id
        }
    }
    
}

//MARK:- GET Card with ID (用ID查詢Card)

struct GetCardWithIDResponse: Codable {
    let status: Bool
    let cardData: CardData?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case status,error
        case cardData = "card_data"
    }
    
    struct CardData: Codable {
        let id: Int
        let cardName: String
        let createUser: String
        let createdAt:String
        let updatedAt: String
        let pivot: Pivot
        let showTasks: [ShowTask?]
        
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
        let title: String
        let status: Bool
        let createUser, updateUser: String
        let description:String?
        let cardID: Int
        let createdAt, updatedAt: String
        
        enum CodingKeys: String, CodingKey {
            case id, title, status
            case createUser = "create_user"
            case updateUser = "update_user"
            case description = "description"
            case cardID = "card_id"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
}


//MARK:- PUT Card (更新card)

struct PutCardResponse: Codable {
    let status: Bool
    let cardData: CardData?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case status,error
        case cardData = "card_data"
    }
    
    struct CardData: Codable {
        let id: Int
        let cardName: String
        let createUser: String
        let createdAt:String
        let updatedAt: String
        let pivot: Pivot
        let showTasks: [ShowTask?]
        
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
        let title: String
        let status: Bool
        let createUser, updateUser: String
        let description:String?
        let cardID: Int
        let createdAt, updatedAt: String
        
        enum CodingKeys: String, CodingKey {
            case id, title, status
            case createUser = "create_user"
            case updateUser = "update_user"
            case description = "description"
            case cardID = "card_id"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
    
}

//MARK:- DELETE card

struct DeleteCardResponse: Codable {
    let status: Bool
    let error: String?
    
}