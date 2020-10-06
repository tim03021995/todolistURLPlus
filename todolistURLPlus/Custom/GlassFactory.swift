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
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = CGRect(x:0, y:0, width: ScreenSize.width.value, height: ScreenSize.height.value)
        visualEffectView.layer.cornerRadius = ScreenSize.height.value * 0.01
        visualEffectView.clipsToBounds = true
        return visualEffectView
    }
    static func makeGlass(style:UIBlurEffect.Style) -> UIVisualEffectView{
        let blurEffect = UIBlurEffect(style: style)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = CGRect(x:0, y:0, width: ScreenSize.width.value, height: ScreenSize.height.value)
        visualEffectView.layer.cornerRadius = ScreenSize.height.value * 0.01
        visualEffectView.clipsToBounds = true
        return visualEffectView
    }
}
