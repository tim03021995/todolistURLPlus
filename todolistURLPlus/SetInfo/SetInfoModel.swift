//
//  SetInfoModel.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/16.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
struct SetInfoModel{
    var UserName:String
    var UserImage:UIImage
}
class SetInfoModelManerger{
    static func updateUserImage(_ image:UIImage,_ compeletion:@escaping ()->Void){
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        let header = ["userToken":token]
        let boundary = "Boundary+\(arc4random())\(arc4random())"
        let dataPath = makeDataPath(image)
        let body = makeBody(dataPath, boundary)
        let request = HTTPRequest(endpoint: .userImage, contentType: .formData, method: .POST, headers: header)
        print(#function)
        NetworkManager().sendRequest(with: request.imageRequest(boundary: boundary, data: body)) { (result:Result<PostUserImageResponse,NetworkError>) in
            switch result {
            case .success( _):
                print("update success")
            case .failure(let err):
                print("update error")
                print(err.description)
                print("錯誤訊息：\(err.errMessage)")
            }
            compeletion()
        }
    }
    static func updateUserName(_ userName:String?,_ compeletion:@escaping ()->Void){
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        let header = ["userToken":token]
        let parameters = makeParameters(userName, nil)
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .PUT, parameters: parameters, headers: header)
        NetworkManager().sendRequest(with: request.send()) { (result:Result<PutUserResponse,NetworkError>) in
            switch result {
            case .success( _):
                print("update success")
            case .failure(let err):
                print("update error")
                print(err.description)
                print("錯誤訊息：\(err.errMessage)")
            }
            compeletion()
        }
    }
    static func makeParameters(_ userName:String?,_ passWord:String?)->[String:Any]{
        var parameters:[String:Any] = [:]
        if let title = userName {
            parameters["username"] = title
        }
        if let description = passWord {
            parameters["password"] = description
        }
        print(parameters)
        return parameters
    }
    static func makeDataPath(_ image:UIImage)->[String:Data]{
        var dataPath:[String:Data] = [:]
        let newImage = image.jpegData(compressionQuality: 0.1)
        dataPath["image"] = newImage
        return dataPath
    }
    private static func makeBody(_ dataPath:[String:Data],_ boundary:String)->Data{
        var body = Data()
        for (key, value) in dataPath {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(arc4random())\"\r\n") //此處放入file name，以隨機數代替，可自行放入
             print(boundary)
            body.appendString(string: "Content-Type: image/png\r\n\r\n") //image/png 可改為其他檔案類型 ex:jpeg
            body.append(value)
            body.appendString(string: "\r\n")
        }
        body.appendString(string: "--\(boundary)--\r\n")
         return body
     }
}
