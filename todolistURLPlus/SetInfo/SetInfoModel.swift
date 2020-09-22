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
        let header = ["userToken":UserToken.shared.userToken]
        let boundary = "Boundary+\(arc4random())\(arc4random())"
        let dataPath = makeDataPath(image)
        let body = makeBody(dataPath, boundary)
        let request = HTTPRequest(endpoint: .task, contentType: .formData, method: .POST, headers: header)
        print(#function)
        NetworkManager.sendRequest(with: request.imageRequest(boundary: boundary, data: body)) { (result:Result<PostTaskResponse,NetworkError>) in
            switch result {
            case .success(let a):
                print("create success")
            case .failure(let err):
                print(" create error")
                print(err.description)
                print("錯誤訊息：\(err.errMessage)")
            }
            compeletion()
        }
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
