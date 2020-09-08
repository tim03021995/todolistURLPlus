//
//  StringExtension.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/8.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation


extension String {
    
    var isValidEMail : Bool {
        let format = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-Z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", format)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPassword : Bool {
        let format = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,8}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", format)
        return passwordPredicate.evaluate(with: self)
    }
    
    var isNameValid : Bool {
        if self.count > 16 || self.count < 1 {
            return false
        }else {
            return true
        }
        
    }
    
}
