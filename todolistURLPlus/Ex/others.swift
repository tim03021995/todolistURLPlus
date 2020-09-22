//
//  others.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

struct StoryboardID{
    static let signUpVC = "signUpVC"
    static let signInVC = "signInVC"
    
}
let fullScreenSize = UIScreen.main.bounds.size

enum ScreenSize{
    case centerX,centerY,width,height,spaceX,spaceY
    var value:CGFloat{
        switch self {
        case .centerX:
            return fullScreenSize.width * 0.5
        case .centerY:
            return fullScreenSize.height * 0.5
        case .width:
            return fullScreenSize.width
        case .height:
            return fullScreenSize.height
        case .spaceX:
            return fullScreenSize.width * 0.1
        case .spaceY:
            return fullScreenSize.height * 0.025
        }
    }
}
extension UIViewController
{
    ///當推出鍵盤時，自動將畫面上移
    func autoPushView(){
        let observer = NotificationCenter.default
        
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
extension UITextView{
    func resetHight(_ textView:UITextView){
        let maxHeight:CGFloat = ScreenSize.height.value * 0.4
        let frame = textView.frame
        let constrainSize=CGSize(width:frame.size.width,height:CGFloat(MAXFLOAT))
        var size = textView.sizeThatFits(constrainSize)
        if size.height >= maxHeight{
            size.height = maxHeight
            textView.isScrollEnabled=true
        }else{
            textView.isScrollEnabled=false
        }
        textView.frame.size.height=size.height
    }
}
extension Data{
    
    mutating func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
class CanLoadViewController:UIViewController{
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
        let animate = UIViewPropertyAnimator(duration: 3, curve: .easeIn) {
            self.glass.alpha = 0
            self.navigationController?.navigationBar.isHidden = false
            self.glass.removeFromSuperview()
            self.loadIndicatorView.removeFromSuperview()
        }
        animate.startAnimation()
    }
    func getImage(type:ImageURLType,imageURL:String,completion:@escaping(UIImage?)->Void){
        var urlStr:String
        switch type {
        case .gill:
            urlStr = "http://35.185.131.56:8002/" + imageURL
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
