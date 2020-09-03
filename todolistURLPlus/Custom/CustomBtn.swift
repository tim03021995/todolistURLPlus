//
//  CustomUI.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/2.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit


class CustomButton: UIButton {
    //純扣的話直接實例化
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpBtn()
    }
    
    //for storyboard
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        setUpBtn()
    }
    
    private func setUpBtn(){
        //TODO 設置按鈕
        backgroundColor = .glassColor
        layer.cornerRadius = frame.size.height/4
        tintColor = .white
        
    }
}
