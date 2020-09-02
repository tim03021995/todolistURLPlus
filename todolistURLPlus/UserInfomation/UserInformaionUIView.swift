//
//  InformaionUIView.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/2.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class UserInfomationView: UIView {
    var glassView : UIView = {
        var uiView = UIView (frame: CGRect(x: 30, y: 50, width: ScreenSize.width.value * 0.9, height: ScreenSize.hight.value * 0.75))
        uiView.center = CGPoint(x: ScreenSize.centerX.value, y: ScreenSize.centerY.value + ScreenSize.hight.value * 0.025)
        uiView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)
        uiView.layer.cornerRadius = 15
        return uiView
    }()
    var backgroundImage : UIImageView = {
        var uiImage = #imageLiteral(resourceName: "backgroundBlurred")
        var imageView = UIImageView(image: uiImage, highlightedImage: nil)
        imageView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width.value, height: ScreenSize.hight.value)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    var userName:UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width:ScreenSize.width.value * 0.2 , height: ScreenSize.hight.value * 0.05))
        label.center = CGPoint(x: ScreenSize.centerX.value, y: ScreenSize.centerY.value * 0.7)
        label.contentMode = .center
        label.text = "Name"
        label.font = .systemFont(ofSize: 30)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(backgroundImage)
        addSubview(glassView)
        addSubview(userName)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
