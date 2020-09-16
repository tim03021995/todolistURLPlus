//
//  LoginResponse.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/14.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation

//MARK:- 登入註冊的資料結構

struct LoginInReaponse:Codable{
    let status: Bool
    var loginData: LoginData?
    
    enum CodingKeys: String, CodingKey {
        case status
        case loginData = "login_data"
    }
}

struct LoginData : Codable {
    var userToken:String
}
