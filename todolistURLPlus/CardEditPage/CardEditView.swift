//
//  CardEditView.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/7.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class CardEditView: UIView {
    
    var titleTextField:UITextField = {
        var textField = UITextField(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.8,
            height: ScreenSize.height.value * 0.05 ))
        textField.textAlignment = .center
        let font = textField.font!
        let newFont = font.withSize(30)
        textField.font = newFont
        return textField
    }()
    var textView:UITextView = {
        var textView = UITextView(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.8,
            height: ScreenSize.height.value * 0.2))
        textView.font = UIFont(name: "Helvetica-Light", size: 20)
        textView.backgroundColor = .backgroundColor
        textView.textAlignment = .center
        return textView
    }()
    var imageView:UIImageView = {
        var imageView = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.7,
            height: ScreenSize.width.value * 0.7))
        imageView.layer.cornerRadius = imageView.frame.width * 0.05
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    var colorView:UIView = {
        var view = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.7,
            height: ScreenSize.height.value * 0.1))
        view.layer.cornerRadius = view.frame.width * 0.05
        view.backgroundColor = .lightGray
        return view
    }()
    var colorButtonRed:UIButton = {
        var button = ColorButtonFactory.makeButton(type: .red)
        return button 
    }()
    var colorButtonOrange:UIButton = {
        var button = ColorButtonFactory.makeButton(type: .orange)
        return button
    }()
    var colorButtonYello:UIButton = {
        var button = ColorButtonFactory.makeButton(type: .yello)
        return button
    }()
    var colorButtonGreen:UIButton = {
        var button = ColorButtonFactory.makeButton(type: .green)
        return button
    }()
    var colorButtonBlue:UIButton = {
        var button = ColorButtonFactory.makeButton(type: .blue)
        return button
    }()
    var colorButtonDarkBlue:UIButton = {
        var button = ColorButtonFactory.makeButton(type: .darkBlue)
        return button
    }()
    var colorButtonPurple:UIButton = {
        var button = ColorButtonFactory.makeButton(type: .purple)
        return button
    }()
    var colorCollectionView:UICollectionView =
    {
        let view = UICollectionView(frame: CGRect(
        x: 0,
        y: 0,
        width: ScreenSize.width.value * 0.7,
        height: ScreenSize.height.value * 0.1))
        view.layer.cornerRadius = view.frame.width * 0.05
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.backgroundColor = .backgroundColor
        setSubView()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubView(){
        addSubview(titleTextField)
        addSubview(textView)
        addSubview(imageView)
        addSubview(colorView)
        colorView.addSubview(colorButtonRed)
        colorView.addSubview(colorButtonOrange)
        colorView.addSubview(colorButtonYello)
        colorView.addSubview(colorButtonGreen)
        colorView.addSubview(colorButtonBlue)
        colorView.addSubview(colorButtonDarkBlue)
        colorView.addSubview(colorButtonPurple)
    }
    private func setConstraints(){
        let centerX = ScreenSize.centerX.value
        //let centerY = ScreenSize.centerY.value
        let space = ScreenSize.spaceY.value
        let colorViewCenterY = colorView.frame.height * 0.5
        let colorViewSpaceX = colorView.frame.width * 0.075
        titleTextField.center = CGPoint(
            x: centerX,
            y: space * 2)
        textView.center = CGPoint(
            x: centerX,
            y: titleTextField.frame.maxY + space + textView.frame.height * 0.5)
        imageView.center = CGPoint(
            x: centerX,
            y: textView.frame.maxY + space + imageView.frame.height * 0.5)
        colorView.center = CGPoint(
            x: centerX,
            y: imageView.frame.maxY + space + colorView.frame.height * 0.5)
        colorButtonRed.center = CGPoint(
            x: colorViewSpaceX,
            y: colorViewCenterY)
        colorButtonOrange.center = CGPoint(
            x:  colorButtonRed.frame.maxX + colorViewSpaceX,
            y: colorViewCenterY)
        colorButtonYello.center = CGPoint(
        x:  colorButtonOrange.frame.maxX + colorViewSpaceX,
        y: colorViewCenterY)
        colorButtonGreen.center = CGPoint(
        x: colorButtonYello.frame.maxX + colorViewSpaceX,
        y:  colorViewCenterY)
        colorButtonBlue.center = CGPoint(
        x: colorButtonGreen.frame.maxX + colorViewSpaceX,
        y:  colorViewCenterY)
        colorButtonDarkBlue.center = CGPoint(
        x:colorButtonBlue.frame.maxX + colorViewSpaceX,
        y:  colorViewCenterY)
        colorButtonPurple.center = CGPoint(
        x:colorButtonDarkBlue.frame.maxX + colorViewSpaceX,
        y:  colorViewCenterY)
    }
    func setUserData(image:UIImage?,title:String?,script:String?){
        if let image = image {
            imageView.image = image
        }else{
            imageView.image = UIImage(systemName: "photo")
        }
        if let title = title {
            titleTextField.text = title
        }else{
            titleTextField.text = "UnKnow"
        }
        if let script = script {
            textView.text = script
        }else{
            textView.text = "UnKnow"
        }
    }
    
}

class  CellOfTextView: UITableViewCell {
    var textView:UITextView = {
        var textView = UITextView(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.8,
            height: ScreenSize.height.value * 0.4))
        textView.font = UIFont(name: "Helvetica-Light", size: 20)
        textView.textAlignment = .left
        return textView
    }()
}
class CellOfImageView:UITableViewCell {
    
}
extension CardEditVC:UICollectionViewDelegate{
    
}
