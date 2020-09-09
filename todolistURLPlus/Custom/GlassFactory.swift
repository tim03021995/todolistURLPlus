//
//  GlassFactory.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/9.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
class  GlassFactory{
    
    static func makeGlass() -> UIVisualEffectView{
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let glassView = UIVisualEffectView(effect: blurEffect)
        glassView.frame = CGRect(x:0, y:0, width: ScreenSize.width.value * 0.9, height: ScreenSize.height.value * 0.8)
        glassView.center = CGPoint(x: ScreenSize.centerX.value, y: ScreenSize.centerY.value + ScreenSize.height.value * 0.04)
        // glassView.backgroundColor = .glassColor
        glassView.layer.cornerRadius = 15
        glassView.clipsToBounds = true
        return glassView
    }
}
