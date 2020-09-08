//
//  SetInfoView.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
class SetInfoView:UIView{
    var backgroundImage : UIImageView = {
        return BackGroundFactory.makeImage(type: .backgroundBlurred)
    }()
    var peopleView:UIImageView = {
        var imageView = UserImageFactory.makeImageView(size: .large, image: nil)
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    var nameTextField:UITextField = {
        var textField = UITextField(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.8,
            height: ScreenSize.height.value * 0.1 ))
        textField.textAlignment = .center
        let font = textField.font!
        let newFont = font.withSize(30)
        textField.font = newFont
        return textField
    }()
    var albumButton:UIButton = {
        var button = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.1,
            height: ScreenSize.width.value * 0.1))
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.layer.cornerRadius = button.frame.height * 0.5
        button.addTarget(self, action: #selector(SetInfoVC.takeImage), for: .touchDown)
        button.backgroundColor = .gray
        return button
    }()
    var saveButton:UIButton = {
        var button = ButtonFactory.makeButton(type: .normal, text: "Save")
        return button
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setSubView()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubView(){
        addSubview(backgroundImage)
        addSubview(peopleView)
        addSubview(saveButton)
        addSubview(nameTextField)
        addSubview(albumButton)
    }
    private func setConstraints(){
        let centerX = ScreenSize.centerX.value
        let centerY = ScreenSize.centerY.value
        let space = ScreenSize.spaceY.value
        peopleView.center = CGPoint(x:centerX, y: centerY * 0.75)
        nameTextField.center = CGPoint(
            x: centerX,
            y: peopleView.frame.maxY + nameTextField.frame.height * 0.5 + space )
        saveButton.center = CGPoint(
            x: centerX,
            y: nameTextField.frame.maxY + saveButton.frame.height * 0.5 + space )
        albumButton.center = CGPoint(
            x: peopleView.frame.maxX - peopleView.frame.width * 0.1,
            y: peopleView.frame.maxY - peopleView.frame.width * 0.1)
    }

    
    func setUserData(userImage:UIImage?,userName:String?){
        if let userImage = userImage {
            self.peopleView.image = userImage
        }else{
            self.peopleView.image = UIImage(systemName: "photo")
        }
        
        if let userName = userName {
            self.nameTextField.text = userName
        }else{
            self.nameTextField.text = "UnKnow"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}

