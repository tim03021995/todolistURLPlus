//
//  DecodeStruct.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/10.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation


//MARK:- GET Task

///GET TASK
struct GetTaskResponse: Codable {
    let status: Bool
    let taskData: [TaskData?]
    
    enum CodingKeys: String, CodingKey {
        case status
        case taskData = "task_data"
    }
    
    
    struct TaskData: Codable {
        let id: Int
        let title: String
        let status: Bool
        let createUser: String
        let updateUser: String
        let description:String?
        let tag: String?
        let image: String?
        let cardID: Int
        let createdAt, updatedAt: String
        
        enum CodingKeys: String, CodingKey {
            case id, title, status, description
            case createUser = "create_user"
            case updateUser = "update_user"
            case tag, image
            case cardID = "card_id"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
}

//MARK:- POST Task (新增task)

///POST TASK
struct PostTaskResponse: Codable {
    let status: Bool
    let taskData: TaskData
    
    enum CodingKeys: String, CodingKey {
        case status
        case taskData = "task_data"
    }
    
    struct TaskData: Codable {
        let title: String
        let status: Bool
        let createUser:String
        let updateUser: String
        let description: String?
        let tag: String
        let image: String?
        let cardID: Int
        let updatedAt: String
        let createdAt: String
        let id: Int
        
        enum CodingKeys: String, CodingKey {
            case title, status, tag, image, description
            case createUser = "create_user"
            case updateUser = "update_user"
            case cardID = "card_id"
            case updatedAt = "updated_at"
            case createdAt = "created_at"
            case id
        }
    }
}

//MARK:- PUT Task （更新Task）

///PUT TASK
struct PutTaskResponse: Codable {
    let status: Bool
    let taskData: TaskData
    
    enum CodingKeys: String, CodingKey {
        case status
        case taskData = "task_data"
    }
}

struct TaskData: Codable {
    let id: Int
    let title: String
    let status: Bool
    let image: String?
    let createUser:String
    let updateUser:String
    let description: String
    let tag: String
    let cardID:Int
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, status, description, tag, image
        case createUser = "create_user"
        case updateUser = "update_user"
        case cardID = "card_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

//MARK:- DELETE Task


///DELETE TASK
struct DeleteTaskResponse: Codable {
    let status: Bool
}
