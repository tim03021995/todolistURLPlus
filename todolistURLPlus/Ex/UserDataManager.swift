//
//  UserData.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/28.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class UserDataManager{
    static let shared = UserDataManager()
    private(set) var userData:GetUserResponse.UserData?
    private(set) var userImage:UIImage?
    private init(){}
    
    
    func getUserData(email:String){
        let headers = ["userToken":UserToken.shared.userToken]
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .GET, headers: headers, mail: email).send()
        NetworkManager.sendRequest(with: request) { [self] (res:Result<GetUserResponse,NetworkError>) in
            switch res {
            case .success(let data ):
                userData = data.userData
                if let imageURL = userData!.image{
                    self.takeImage(imageURL)
                }
            case .failure(let err): print(err.description)
            print(err.errMessage)
            }
        }
    }
    
    private func takeImage(_ imageURL:String){
        let controller = CanGetImageViewController()
        controller.getImage(type: .gill, imageURL: imageURL) { (image) in
            self.userImage = image
        }
    }
}
