//
//  others.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

enum StoryboardID:String{
    case signUpVC
    case signInVC
    
}
let fullScreenSize = UIScreen.main.bounds.size

enum ScreenSize{
    case centerX,centerY,width,hight,spaceX,spaceY
    var value:CGFloat{
        switch self {
        case .centerX:
            return fullScreenSize.width * 0.5
        case .centerY:
            return fullScreenSize.height * 0.5
        case .width:
            return fullScreenSize.width
        case .hight:
            return fullScreenSize.height
        case .spaceX:
            return fullScreenSize.width * 0.1
        case .spaceY:
            return fullScreenSize.height * 0.025
        }
    }
}



