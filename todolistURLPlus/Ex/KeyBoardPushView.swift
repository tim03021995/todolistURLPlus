//
//  KeyBoardPushView.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/25.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
extension UIViewController
{
    ///當推出鍵盤時，自動將畫面上移
    func autoPushView(){
        let observer = NotificationCenter.default
        
        //NotificationCenter.default.addObserver(觀察者, selector: #selector(觀察者用來處理通知的方法), name: 通知的名稱, object: 要觀察的對象物件)
        observer.addObserver(self, selector: #selector(pushView), name: UIResponder.keyboardWillShowNotification, object: nil)
        observer.addObserver(self, selector: #selector(closeView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func pushView(){
        let animate = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
            self.view.center = CGPoint(x: ScreenSize.centerX.value, y: ScreenSize.centerY.value * 0.5)
        }
        animate.startAnimation()
    }
    @objc func closeView(){
        let animate = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
            self.view.center = CGPoint(x: ScreenSize.centerX.value, y: ScreenSize.centerY.value )
        }
        animate.startAnimation()
    }
    
}
