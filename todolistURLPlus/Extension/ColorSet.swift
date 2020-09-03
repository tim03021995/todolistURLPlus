//
//  ColorSet.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/2.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
extension UIColor{
    static let backgroundColor = #colorLiteral(red: 0.9647054076, green: 0.9608286023, blue: 0.9606233239, alpha: 1)
    static let mainColor = #colorLiteral(red: 0.01043920591, green: 0.206171751, blue: 0.301853627, alpha: 1)
    static let mainColor2 = #colorLiteral(red: 0.0949748382, green: 0.3313525617, blue: 0.4520905614, alpha: 1)
    static let textColor = #colorLiteral(red: 0.9647054076, green: 0.9608286023, blue: 0.9606233239, alpha: 1)
    static let glassColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)
    static let glassMainColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
}
let fullScreenSize = UIScreen.main.bounds.size

enum ScreenSize{
    case centerX,centerY,width,hight
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
        }
    }
}
