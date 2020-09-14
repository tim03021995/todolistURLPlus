//
//  TaskModel.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/8.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
struct TaskModel{
    var funtionType:FuntionType? //編輯還是新增，如果是新增
    var cardID:Int?
    var taskID:Int?
    var title:String?
    var description:String?
    var image:UIImage?
    var tag:ColorsButtonType?
    enum FuntionType {
        case create,edit
    }
}

