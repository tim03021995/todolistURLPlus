//
//  CustomUI.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/2.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit


class CustomButton: UIButton {
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
class ButtonFactory{
    static func makeButton(type:ButtonType,text:String) -> UIButton {
        let button = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.35,
            height: ScreenSize.height.value * 0.075))
        button.setTitle(text, for: .normal)
        button.layer.cornerRadius = button.frame.size.height/4
        switch type {
        case .normal:
            button.backgroundColor = .gray
            button.setTitleColor(.white, for: .normal)
        case .cancel:
            button.backgroundColor = .darkGray
            button.setTitleColor(.red, for: .normal)
        }
        return button
    }
    enum  ButtonType{
        case normal,cancel
    }
}
class ColorButtonFactory{
//    static func makeButton(type:ButtonType) -> UICollectionViewCell{
//
//        let button = UICollectionViewCell(frame: CGRect(
//            x: 0,
//            y: 0,
//            width: ScreenSize.height.value * 0.045,
//            height: ScreenSize.height.value * 0.045))
//        button.layer.cornerRadius = button.frame.size.height * 0.5
//        let color  : UIColor = {
//            switch type {
//            case .red:
//                return UIColor.buttonRed
//            case .orange:
//                return UIColor.buttonOrange
//            case .yello:
//                return UIColor.buttonYello
//            case .green:
//                return UIColor.buttonGreen
//            case .blue:
//                return UIColor.buttonBlue
//            case .darkBlue:
//                return UIColor.button2u04
//            case .purple:
//                return UIColor.buttonPurple
//            }
//        }()
//        button.backgroundColor = color
//        return button
//    }
    enum  ButtonType:CaseIterable{
        case red,orange,yellow,green,blue,darkBlue,purple
    }
}
enum  ColorsButtonType:CaseIterable{
    case red,orange,yellow,green,blue,darkBlue,purple
    
    var color:UIColor{
        switch self{
        case .red:
            return UIColor.buttonRed
        case .orange:
            return UIColor.buttonOrange
        case .yellow:
            return UIColor.buttonYellow
        case .green:
            return UIColor.buttonGreen
        case .blue:
            return UIColor.buttonBlue
        case .darkBlue:
            return UIColor.button2u04
        case .purple:
            return UIColor.buttonPurple
        }
}
}



