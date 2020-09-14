//
//  ForgotPasswordView.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/9.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
import SnapKit
class ForgotPasswordView: UIView {
    private var backgroundImage : UIImageView = {
        return BackGroundFactory.makeImage(type: .background1)
    }()
    
    var title:UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width:ScreenSize.width.value * 0.7 , height: ScreenSize.height.value * 0.3))
        label.contentMode = .center
        label.text = "Forgot password?"
        label.font = .systemFont(ofSize: 100)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    private var confirmButton:UIButton = {
        var button = ButtonFactory.makeButton(type: .normal, text: "confirm")
        return button
    }()
    private var nameTextField:UITextField = {
        var textField = UITextField(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.8,
            height: ScreenSize.height.value * 0.1 ))
        textField.textAlignment = .center
        let font = textField.font!
        let newFont = font.withSize(30)
        textField.font = newFont
        textField.backgroundColor = .black
        return textField
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setSubView()
        constraint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubView(){
        addSubview(backgroundImage)
        addSubview(title)
        addSubview(confirmButton)
        addSubview(nameTextField)
    }
    private func constraint(){
        let centerX = ScreenSize.centerX.value
        let spaceY = ScreenSize.spaceY.value
        title.center = CGPoint(
            x: centerX,
            y: ScreenSize.centerY.value * 0.25)
        confirmButton.center = CGPoint(
            x: centerX,
            y: ScreenSize.height.value - spaceY * 6 )
        nameTextField.center = CGPoint(
            x: centerX,
            y: ScreenSize.centerY.value)


    }
    
    
    
}
