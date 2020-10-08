//
//  Extension.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/10/6.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

extension UIViewController: ResponseActionDelegate {
    func shouldRetry() {
        present(.makeAlert("錯誤", "請稍後再試", {
            UserToken.clearToken()
            self.dismiss(animated: false, completion: nil)
            return nil
        }) ,animated: true)
    }
    
    func shouldRefreshToken() {
        present(.makeAlert("逾時", "請重新登入", {
            let vc = LoginVC.instantiate()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            return nil
        }) ,animated: true)
    }
    
    static func makeAlert(_ title: String?, _ message: String?, _ handler:@escaping (() -> Void?)) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
            handler()
        })
        alert.addAction(action)
        return alert
    }
    
}

extension UserDefaults{
    
    func setIsLoggedInStatus (status:Bool) {
        set(status, forKey: "loginStatus")
        synchronize()
    }
    func isLoggedIn() -> Bool{
        return bool(forKey: "loginStatus")
    }
    
    func saveAccount(account:String) {
        set(account, forKey: "userAccount")
        synchronize()
    }
    
    func getUserAccount() -> String {
        if isLoggedIn(){
            return string(forKey: "userAccount") ?? ""
        }else {
            return ""
        }
    }
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]
        
        // load our storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}




