//
//  ForgotPasswordView.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/9.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
import SnapKit
class ModifyPasswordView: UIView {
    private var backgroundImage : UIImageView = {
        return BackGroundFactory.makeImage(type: .background1)
    }()
    
    var title:UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width:ScreenSize.width.value * 0.7 , height: ScreenSize.height.value * 0.3))
        label.contentMode = .center
        label.text = "Modify password?"
        label.font = .systemFont(ofSize: 100)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    var confirmButton:UIButton = {
        var button = ButtonFactory.makeButton(type: .normal, text: "confirm")
        button.addTarget(nil, action: #selector(ModifyPasswordVC.touchConfirmButton), for: .touchUpInside)
        return button
    }()
    var passwordTextField:CustomLogINTF = {
        var textField = CustomLogINTF(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.8,
            height: ScreenSize.height.value * 0.05 ))
        textField.textAlignment = .center
        return textField
    }()
    var alertLabel:UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width:ScreenSize.width.value * 0.7 , height: ScreenSize.height.value * 0.3))
        //label.contentMode = .center
        label.text = "password should over 8 characters and only 0-9,a-z,A-Z."
        label.font = .systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .red
        label.alpha = 0
        return label
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
        addSubview(passwordTextField)
        addSubview(alertLabel)
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
        passwordTextField.center = CGPoint(
            x: centerX,
            y: ScreenSize.centerY.value)
        alertLabel.snp.makeConstraints { (make) in
            make.left.right.width.equalTo(passwordTextField)
            make.height.equalTo(passwordTextField).multipliedBy(0.5)
            make.top.equalTo(passwordTextField.snp.bottom).offset(spaceY)
        }


    }
    
    
    
}
