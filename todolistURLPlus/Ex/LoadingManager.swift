//
//  LoadingManager.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/10/8.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
import Lottie

protocol LoadAnimationAble {
    func startLoading(_ vc: UIViewController)
    func stopLoading()
}
//extension內的where Self意思是這個擴充只在UIViewController生效，若是其他類別遵從這個協議，則這個擴充無效
extension LoadAnimationAble where Self: UIViewController
{
    func startLoading(_ vc: UIViewController)
    {
        LoadManager.share.startLoading(vc)
    }
    func stopLoading()
    {
        LoadManager.share.stopLoading()
    }
}
class LoadManager
{
     
    static let share = LoadManager()
    let disenableView: UIView =
        {
            let disenableView = UIView()
            disenableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            return disenableView
        }()
    let animationView = AnimationView(name: "loading")
    let loadingLabel: UILabel =
        {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.text = "Loading..."
            label.textColor = .white
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
    func startLoading(_ vc:UIViewController){
        disenableView.frame = vc.view.frame
        disenableView.addSubview(animationView)
        animationView.addSubview(loadingLabel)
        vc.view.addSubview(disenableView)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let frame = CGRect(x: width / 2, y: height / 2, width: width / 2, height: width / 2)
        animationView.frame = frame
        animationView.center = vc.view.center
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 0.5
        animationView.play()
        loadingLabel.frame.size = CGSize(width: animationView.bounds.width / 2, height: animationView.bounds.width / 4)
        loadingLabel.center.x = animationView.bounds.midX
        loadingLabel.center.y = animationView.bounds.height / 4
        
    }
     func stopLoading()
    {
        self.disenableView.removeFromSuperview()
    }
    
}
