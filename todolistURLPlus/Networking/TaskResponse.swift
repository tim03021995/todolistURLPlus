//
//  DecodeStruct.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/10.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation


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

