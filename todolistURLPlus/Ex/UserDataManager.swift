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
    private(set) var email:String?
    private init(){}
    
    func getUserData(){
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        let headers = ["userToken":token]
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .GET, headers: headers, mail: email).send()
        NetworkManager().sendRequest(with: request) { (res:Result<GetUserResponse,NetworkError>) in
            switch res {
            case .success(let data ):
                self.userData = data.userData
                if let imageURL = self.userData!.image{
                    self.takeImage(imageURL) { (image) -> Void? in
                    print(image)
                    }
                }
            case .failure(let err): print(err.description)
            print(err.errMessage)
            }
        }
    }
    func getUserData(complection:@escaping (UIImage)->Void){
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        let headers = ["userToken":token]
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .GET, headers: headers, mail: email).send()
        NetworkManager().sendRequest(with: request) { (res:Result<GetUserResponse,NetworkError>) in
            switch res {
            case .success(let data ):
                self.userData = data.userData
                if let imageURL = self.userData!.image{
                    self.takeImage(imageURL, complection: complection)
                }
            case .failure(let err): print(err.description)
            print(err.errMessage)
            }
        }
    }
    func getUserData(email:String,complection:@escaping (UIImage)->Void){
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        let headers = ["userToken":token]
        
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .GET, headers: headers, mail: email).send()
        NetworkManager().sendRequest(with: request) {  (res:Result<GetUserResponse,NetworkError>) in
            switch res {
                
            case .success(let data ):
                self.userData = data.userData
                self.email = email
                if let imageURL = self.userData!.image{
                    self.takeImage(imageURL, complection: complection)
                }
            //TODO顯示
            case .failure(let err): print(err.description)
            //alert
            print(err.errMessage)
            }
        }
    }
    
    func clearData(){
        self.userData = nil
        self.userImage = nil
        self.email = nil
    }
    
    private func takeImage(_ imageURL:String,complection:@escaping (UIImage)->Void?){
        let controller = CanGetImageViewController()
        controller.getImage(type: .gill, imageURL: imageURL) { (image) in
            self.userImage = image
            complection(image!)
        }
    }
    
}
