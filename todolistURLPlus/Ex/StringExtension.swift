//
//  StringExtension.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/8.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation


extension String {
    var isValidUserName:Bool {
        let format =
            "^([-_a-zA-Z0-9]{1,16})$"
        let userNamePredicate = NSPredicate(format: "SELF MATCHES %@", format)
        return userNamePredicate.evaluate(with: self)
    }
    var isValidEMail : Bool {
        
//        "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-Z]{2,64}"
        let format = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,64})$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", format)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPassword : Bool {
        let format = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", format)
        return passwordPredicate.evaluate(with: self)
    }
    
    var isValidName : Bool {
        if self.count > 16 || self.count < 2{
            return false
        }else {
            return true
        }
        
    }
    
}
