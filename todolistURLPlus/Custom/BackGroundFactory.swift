//
//  BackGroundFactory.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/7.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
class BackGroundFactory{
    enum backGroundType{
        case background1,background2,backgroundBlurred
    }
    static func makeImage(type:backGroundType)->UIImageView{
        
        let backgroundImage : UIImageView = {
            var uiImage:UIImage
            switch type{
            case .background1:
                uiImage = #imageLiteral(resourceName: "background1.png")
            case .background2:
                uiImage = #imageLiteral(resourceName: "background2.png")
            case .backgroundBlurred:
                uiImage = #imageLiteral(resourceName: "backgroundBlurred.png")
            }
            let imageView = UIImageView(image: uiImage, highlightedImage: nil)
            imageView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width.value, height: ScreenSize.height.value)
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
        return backgroundImage
    }

}
