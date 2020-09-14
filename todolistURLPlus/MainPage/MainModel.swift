//
//  CardModel.swift
//  todolistURLPlus
//
//  Created by Jimmy on 2020/9/14.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

struct MainModel
{
    var headImage: UIImage?
    var userName: String?
    var workStatus: WorkStatus?
    var cardID:Int?
    var cardTitle: String?
    var taskModel: [TaskModel]?
}

enum WorkStatus
{
    case personal, mutiple
}
