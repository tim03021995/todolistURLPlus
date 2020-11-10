//
//  SetInfoView.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
class SetInfoView: UIView {
    private var backgroundImage: UIImageView = {
        BackGroundFactory.makeImage(type: .backgroundBlurred)
    }()

    lazy var peopleView: UIImageView = {
        var imageView = UserImageFactory.makeImageView(size: .large, image: nil)
        imageView.backgroundColor = .gray
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    var nameTextField: UITextField = {
        var textField = UITextField(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.8,
            height: ScreenSize.height.value * 0.1
        ))
        textField.textAlignment = .center
        let font = textField.font!
        let newFont = font.withSize(30)
        textField.font = newFont
        textField.keyboardType = .asciiCapable
        return textField
    }()

    private var saveButton: UIButton = {
        var button = ButtonFactory.makeButton(type: .normal, text: "Save")
        button.addTarget(self, action: #selector(SetInfoVC.save), for: .touchDown)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubView()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setSubView() {
        addSubview(backgroundImage)
        addSubview(peopleView)
        addSubview(saveButton)
        addSubview(nameTextField)
    }

    private func setConstraints() {
        let centerX = ScreenSize.centerX.value
        let centerY = ScreenSize.centerY.value
        let space = ScreenSize.spaceY.value
        peopleView.center = CGPoint(x: centerX, y: centerY * 0.75)
        nameTextField.center = CGPoint(
            x: centerX,
            y: peopleView.frame.maxY + nameTextField.frame.height * 0.5 + space
        )
        saveButton.center = CGPoint(
            x: centerX,
            y: nameTextField.frame.maxY + saveButton.frame.height * 0.5 + space
        )
    }

    func setUserData(userImage: UIImage, userName: String) {
        peopleView.image = userImage
        nameTextField.text = userName
    }

    func setPhoto(userImage: UIImage) {
        peopleView.image = userImage
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        endEditing(true)
    }
}
