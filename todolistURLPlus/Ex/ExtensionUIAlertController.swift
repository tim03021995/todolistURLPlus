//
//  ExtensionUIAlertController.swift
//  ToDoList
//
//  Created by 陳裕銘 on 2020/7/31.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit
extension UIViewController
{
    func alertMessage(alertTitle: String, alertMessage: String, actionTitle: String)
    {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
      
        let okAction = UIAlertAction(title: actionTitle, style: .destructive){ (action) in
            
         
            }
            
        
     
        alert.addAction(okAction)
        
        
        present(alert, animated: true, completion: nil)
    }
    
}
