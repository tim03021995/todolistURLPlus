//
//  Alert.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

extension UIViewController{
    
    static func makeAlert(_ title: String?, _ message: String?, _ handler:@escaping (() -> Void?)) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
            handler()
        })
        alert.addAction(action)
        return alert
    }
    
}
