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
    
    convenience init(_ presentationStyle:UIModalPresentationStyle , _ transitionStyle:UIModalTransitionStyle?) {
        self.init(nibName:nil, bundle: nil)
        self.modalPresentationStyle = presentationStyle
        if let transitionStyle = transitionStyle {
            self.modalTransitionStyle = transitionStyle
        }
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

extension UIViewController:LoadingViewDelegate{
    
    
    func loadingActivityView() {
        DispatchQueue.main.async {
            self.view.addSubview(self.loadingView)
            let animate = UIViewPropertyAnimator(duration: 2, curve: .easeIn) {
                self.navigationController?.navigationBar.isHidden = true
            }
            animate.startAnimation()
            print("startLoading")
            
        }
    }
    
    func stopLoadActivityView() {
        DispatchQueue.main.async {
            
            let animate = UIViewPropertyAnimator(duration: 2, curve: .easeIn) {
            }
            animate.addCompletion { (pos) in
                if pos == .end{
                    self.loadingView.removeFromSuperview()
                }
            }
            animate.startAnimation()
            print("finishLoading")
        }
    }
    
    var loadingView: UIView {
        
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = .red
        //            let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        //            let glassView = UIVisualEffectView(effect: blurEffect)
        //            glassView.frame = CGRect(x:0, y:0, width: ScreenSize.width.value, height: ScreenSize.height.value)
        //            glassView.alpha = 1
        //            view.addSubview(glassView)
        //        view.isUserInteractionEnabled = true
        return view
    }
    
    
    
    
}
