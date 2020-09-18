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
        data.tag = view.selectColor
        if view.imageView.image != UIImage(systemName: "photo"){
            data.image = view.imageView.image
        }else{
            data.image = nil
        }
        return data
    }
    static func create(_ cardID:Int, _ view:CardEditView){
        let boundary = "Boundary+\(arc4random())\(arc4random())"
        let parameters = makeParameters(cardID,view,.POST)
        let dataPath = makeDataPath(view)
        let body = makeBody(parameters, dataPath, boundary)
        let request = makeRequest(body: body, boundary: boundary, endpoint: .task, id: nil, httpMethod: .POST)
        print(#function)
        NetworkManager().sendRequest(with: request) { (result:Result<PostTaskResponse,NetworkError>) in
            switch result {
            case .success(let a):
                print("create success")
                print(a)
            case .failure(let err):
                print(" create error")
                print(err.description)
                print("錯誤訊息：\(err.errMessage)")
            }
        }
    }
    static func edit(_ cardID:Int,_ taskID:Int, _ view:CardEditView){
           let boundary = "Boundary+\(arc4random())\(arc4random())"
           let parameters = makeParameters(cardID,view,.PUT)
           let dataPath = makeDataPath(view)
           let body = makeBody(parameters, dataPath, boundary)
           print(parameters)
        let request = makeRequest(body: body, boundary: boundary, endpoint: .task, id: taskID, httpMethod: .POST)
        print(#function)
           NetworkManager().sendRequest(with: request) { (result:Result<PutTaskResponse,NetworkError>) in
               switch result {
               case .success(let a):
                   print("create success")
                   print(a)
               case .failure(let err):
                   print(" create error")
                   print(err.description)
                   print("錯誤訊息：\(err.errMessage)")
               }
           }
       }
    private static func makeRequest(body:Data,boundary:String,endpoint:Endpoint,id:Int?,httpMethod:HTTPMethod)->URLRequest{
        let baseURL = "http://35.185.131.56:8002/api/"
        var urlString:String {
            if let id = id {
                return baseURL + endpoint.rawValue + "/" + "\(id)"
            } else {
                return baseURL + endpoint.rawValue
            }
        }
        let url = URL(string:urlString)
        var request = URLRequest(url: url!)
        let userToken = ["userToken":UserToken.shared.userToken]
        request.httpMethod = HTTPMethod.POST.rawValue
        request.allHTTPHeaderFields = userToken
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        return request
    }
    
    static func makeParameters(_ cardID:Int,_ view:CardEditView,_ method:HTTPMethod)->[String:Any]{
        var parameters:[String:Any] = [:]
        let data = getViewData(view: view)
        if let title = data.title {
            parameters["title"] = title
        }
        if let description = data.description {
            parameters["description"] = description
        }
        if method == .PUT {
        parameters["_method"] = "PUT"
        }
        parameters["card_id"] = cardID
        parameters["tag"] = data.tag
        print(parameters)
        return parameters
    }
        static func makeDataPath(_ view:CardEditView)->[String:Data]{
            var dataPath:[String:Data] = [:]
            let data = getViewData(view: view)
            if let image = data.image {
                let data = image.jpegData(compressionQuality: 0.1)
                dataPath["image"] = data
            }
            return dataPath
        }
    private static func makeBody(_ parameters:[String:Any],_ dataPath:[String:Data],_ boundary:String)->Data{
        var body = Data()
        
        for (key, value) in parameters {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }
        for (key, value) in dataPath {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(arc4random())\"\r\n") //此處放入file name，以隨機數代替，可自行放入
            body.appendString(string: "Content-Type: image/png\r\n\r\n") //image/png 可改為其他檔案類型 ex:jpeg
            body.append(value)
            body.appendString(string: "\r\n")
        }
        
        body.appendString(string: "--\(boundary)--\r\n")
         return body
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
