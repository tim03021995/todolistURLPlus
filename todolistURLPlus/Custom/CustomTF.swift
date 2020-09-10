//
//  CustomTF.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/2.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class CustomLogINTF:UITextField{
    override init(frame: CGRect) {
        super.init(frame:frame)
        setTF()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        setTF()
    }
    
    func setTF(){
        textColor = .white
        backgroundColor = UIColor(white: 0, alpha: 0.1)
        borderStyle = .none
//        placeholder = "123"
        //改placeholder 顏色
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray ])

        
        
        

        
    }
}

