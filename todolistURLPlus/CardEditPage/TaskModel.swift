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
        case create,edit,delete
    }
}
class TaskModelManerger{
    
    private static func getViewData(view:CardEditView)->TaskModel{
        var data = TaskModel()
        data.title = view.titleTextField.text
        data.description = view.textView.text
        if view.imageView.image != UIImage(systemName: "photo"){
            data.image = view.imageView.image
        }else{
            data.image = nil
        }
        return data
    }
    static func makeParameters(_ cardID:Int,_ color:ColorsButtonType, _ view:CardEditView)->[String:Any]{
        var parameters:[String:Any] = [:]
        let data = getViewData(view: view)
        if let title = data.title {
            parameters["title"] = title
        }
        if let description = data.description {
            parameters["description"] = description
        }
//        if let image = data.image {
//            parameters["image"] = image
//        }
        parameters["card_id"] = cardID
       // parameters["task_id"] = taskID
        parameters["tag"] = color.rawValue
        return parameters
    }
    static func create(_ parameters:[String:Any]){
        let headers = ["userToken":UserToken.shared.userToken]
        let request = HTTPRequest(endpoint: .task, contentType: .json, method: .POST, parameters: parameters , headers:  headers)
        NetworkManager().sendRequest(with: request.send()) { (result:Result<PostTaskResponse,NetworkError>) in
            switch result {
            case .success(let a):
                print("create success")
            case .failure(let err):
                print(err)
            }
        }
    }
    static func edit(_ parameters:[String:Any],_ taskID:Int){
        let headers = ["userToken":UserToken.shared.userToken]
        let request = HTTPRequest(endpoint: .task, contentType: .json, method: .PUT, parameters: parameters, headers: headers, id: taskID)
        NetworkManager().sendRequest(with: request.send()) { (result:Result<PostTaskResponse,NetworkError>) in
            switch result {
            case .success(let a):
                print("edit success")
                print(a.taskData)
            case .failure(let err):
                print(err)
            }
        }
    }
    static func delete(_ taskID:Int){
        let headers = ["userToken":UserToken.shared.userToken]
        let request = HTTPRequest(endpoint:.task, contentType: .json, method:.DELETE, headers: headers, id:taskID).send()
        NetworkManager().sendRequest(with: request) { (result:Result<DeleteTaskResponse,NetworkError>) in
            switch result {
            case .success(let a):
                print("delete success")
            case .failure(let err):
                print(err)
            }
        }
    }
}
