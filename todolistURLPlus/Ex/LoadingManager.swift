//
//  LoadingManager.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/10/8.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

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
        let animate = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            vc.navigationController?.navigationBar.isHidden = true
            self.glass.alpha = 1
        }
        loadIndicatorView.startAnimating()
        animate.startAnimation()
    }
    
    func stopLoading(){
        let animate = UIViewPropertyAnimator(duration: 3, curve: .linear) {
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
    func startLoading429(vc:UIViewController){
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
        vc.view.addSubview(glass)
        vc.view.addSubview(loadIndicatorView)
        vc.view.addSubview(worngText)
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
