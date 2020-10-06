//
//  CanGetImageViewController.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/25.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
#warning("使用protocol")
class CanGetImageViewController:UIViewController{
    let loadIndicatorView:UIActivityIndicatorView = {
        var loading = UIActivityIndicatorView()
        loading.center = CGPoint(x: ScreenSize.centerX.value, y: ScreenSize.centerY.value)
        loading.color = .white
        loading.style = .large
        
        return loading
    }()
    let glass:UIView = {
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let glassView = UIVisualEffectView(effect: blurEffect)
        glassView.frame = CGRect(x:0, y:0, width: ScreenSize.width.value, height: ScreenSize.height.value)
        glassView.layer.cornerRadius = 15
        glassView.clipsToBounds = true
        return glassView
    }()
    func loading(){
        glass.alpha = 0
        self.view.addSubview(glass)
        self.view.addSubview(loadIndicatorView)
        loadIndicatorView.startAnimating()
        let animate = UIViewPropertyAnimator(duration: 3, curve: .easeIn) {
            self.navigationController?.navigationBar.isHidden = true
            self.glass.alpha = 1
        }
        animate.startAnimation()
    }
    func stopLoading(){
        let animate = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
            self.glass.alpha = 0
        }
        animate.addCompletion { (position) in
            if position == .end {
                self.navigationController?.navigationBar.isHidden = false
                self.loadIndicatorView.removeFromSuperview()
                self.glass.removeFromSuperview()
            }
        }
        animate.startAnimation()
    }
    func getImage(type:ImageURLType,imageURL:String,completion:@escaping(UIImage?)->Void){
        var urlStr:String
        switch type {
        case .gill:
            urlStr = "http://35.185.131.56:8002/" + imageURL
            print(imageURL)
        case .other:
            urlStr = imageURL
        }
        let url = URL(string: urlStr)!
        do
        {
        let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            completion(image)
        }catch
        {
            print("image is error")
        }
    }
    enum ImageURLType{
        case gill,other
    }
}

