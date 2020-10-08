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


class LoadingManager:UIViewController{
    let loadIndicatorView:UIActivityIndicatorView = {
        var loading = UIActivityIndicatorView()
        loading.center = CGPoint(x: ScreenSize.centerX.value, y: ScreenSize.centerY.value)
        loading.color = .white
        loading.style = .large
        return loading
    }()
    
   lazy var glass:UIView = {
    let blurEffect = UIBlurEffect(style: .dark)
        let glassView = UIVisualEffectView(effect: blurEffect)
        glassView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width.value, height: ScreenSize.height.value)
        glassView.alpha = 1
        glassView.isUserInteractionEnabled = true
        return glassView
    }()
    func startLoading(vc:UIViewController){
        vc.view.addSubview(glass)
        vc.view.addSubview(loadIndicatorView)
        glass.alpha = 0.1
        let animate = UIViewPropertyAnimator(duration: 0, curve: .easeIn) {
            vc.navigationController?.navigationBar.isHidden = true
            self.glass.alpha = 1
        }
        loadIndicatorView.startAnimating()
        animate.startAnimation()
    }
    
    func stopLoading(){
        let animate = UIViewPropertyAnimator(duration: 2, curve: .easeIn) {
            self.glass.alpha = 0
        }
        animate.addCompletion { (position) in
            if position == .end {
                self.loadIndicatorView.removeFromSuperview()
                self.glass.removeFromSuperview()
            }
        }
        animate.startAnimation()
    }
    func startLoading429(){
        self.loadIndicatorView.removeFromSuperview()
        self.glass.removeFromSuperview()
        let worngText:UILabel = {
            let label = UILabel(frame: CGRect(
                                    x: 0, y: ScreenSize.centerY.value * 0.75, width: ScreenSize.width.value, height: 100))
            label.text = "系統存取中，稍後再試..."

            label.textColor = .red
            label.textAlignment = .center
            return label
        }()
        glass.alpha = 0
        self.view.addSubview(glass)
        self.view.addSubview(loadIndicatorView)
        self.view.addSubview(worngText)
        loadIndicatorView.startAnimating()
        let animate = UIViewPropertyAnimator(duration: 5, curve: .easeIn) {
            self.glass.alpha = 1
        }
        let endAnimate = UIViewPropertyAnimator(duration: 5, curve: .easeIn) {
            self.glass.alpha = 0.1
        }
        endAnimate.addCompletion { (position) in
            if position == .end {
            self.loadIndicatorView.removeFromSuperview()
            self.glass.removeFromSuperview()
            worngText.removeFromSuperview()
            }
        }
        animate.addCompletion { (position) in
            if position == .end {
            endAnimate.startAnimation()
            }
        }
        animate.startAnimation()

    }
}
