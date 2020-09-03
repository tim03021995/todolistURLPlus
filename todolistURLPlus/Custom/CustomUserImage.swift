//
//  CustomUserImage.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class userImageFactory{
    static func makeImageView(size:ImageType,image:UIImage?)->UIImageView{
        let imageView = UIImageView()
        if let image = image {
            imageView.image = image
        }else{
            imageView.image = UIImage(systemName: "photo")
        }
        var  radius = ScreenSize.width.value
        switch size {
        case .large:
            radius = radius * 0.9
        case .medium:
            radius = radius * 0.3
        case .small:
            radius = radius * 0.1
        }
        imageView.frame = CGRect(
        x: 0,
        y: 0,
        width: radius,
        height: radius)
        print(radius)
        imageView.layer.cornerRadius = radius * 0.5
        imageView.clipsToBounds = true
        return imageView
    }
    enum  ImageType {
        case large,medium,small
    }
}
