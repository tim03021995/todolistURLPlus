//
//  CustomUserImage.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class UserImageFactory{
    static func makeImageView(size:ImageType,image:UIImage?)->UIImageView{
        let imageView = UIImageView()
        if let image = image {
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
        }else{
            let  image = UIImage(named: "single")
            imageView.image = image
//            imageView.tintColor = .black
//            imageView.backgroundColor = .white
            imageView.contentMode = .scaleAspectFill
        }
        var  radius = ScreenSize.width.value
        switch size {
        case .large:
            radius = radius * 0.6
        case .medium:
            radius = radius * 0.3
        case .small:
            radius = radius * 0.2
        }
        imageView.frame = CGRect(
        x: 100,
        y: 78,
        width: radius,
        height: radius)
        imageView.layer.cornerRadius = radius * 0.5
        imageView.clipsToBounds = true
        return imageView
    }
    enum  ImageType {
        case large,medium,small
    }
}
