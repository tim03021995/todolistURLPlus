//
//  CardEditView.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/7.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
import SnapKit

class CardEditView: UIView {
    let space = ScreenSize.spaceY.value
    var selectColor:ColorsButtonType?
    var scrollView:UIScrollView = {
        var scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width.value, height: ScreenSize.height.value))
        scrollView.contentSize = CGSize(width: ScreenSize.width.value, height: ScreenSize.height.value * 1.2)
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.backgroundColor = .backgroundColor
        return scrollView
    }()
    var titleTextField:UITextField = {
        var textField = UITextField(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.8,
            height: ScreenSize.height.value * 0.1 ))
        textField.textAlignment = .center
        textField.placeholder = "Please input title"
        textField.textColor = .black
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
        textView.backgroundColor = .lightGray
        textView.textAlignment = .center
        textView.layer.cornerRadius = textView.frame.width * 0.05
        return textView
    }()
    var imageView:UIImageView = {
        var imageView = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.8,
            height: ScreenSize.width.value * 0.8))
        imageView.layer.cornerRadius = imageView.frame.width * 0.05
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private var albumButtonBackground:UIVisualEffectView = {
        var button = ConerRadiusButtonBackground(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.1,
            height: ScreenSize.width.value * 0.1))
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        button.effect = blurEffect
        button.clipsToBounds = true
        return button
    }()
    private var albumButton:UIButton = {
        var button = ConerRadiusButton(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.1,
            height: ScreenSize.width.value * 0.1))
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.layer.cornerRadius = button.frame.height * 0.5
        button.addTarget(self, action: #selector(CardEditVC.takeImage), for: .touchUpInside)
        button.backgroundColor = .clear
        button.tintColor = .textColor
        return button
    }()
    var colorsCollectionView:UICollectionView = {
        let viewWidth = ScreenSize.width.value * 0.8
        let cellWidth = ScreenSize.height.value * 0.045
        let allItemWidth = cellWidth * 7
        let space = (viewWidth - allItemWidth) / 8
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth,
                                 height: cellWidth)
        layout.sectionInset = UIEdgeInsets(top: 0, left: space, bottom: 0, right: 0);
        layout.minimumLineSpacing = space
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let view = UICollectionView(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.7,
            height: ScreenSize.height.value * 0.2),
                                    collectionViewLayout: layout
        )
        view.layer.cornerRadius = view.frame.width * 0.05
        view.backgroundColor = .lightGray
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    var deleteButton:UIButton = {
        let button = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.7,
            height: ScreenSize.height.value * 0.2)
        )
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(CardEditVC.deleteTask), for: .touchUpInside)
        button.layer.cornerRadius = button.frame.width * 0.05
        button.backgroundColor = .lightGray
        return button
    }()
    override init(frame: CGRect) {
        super .init(frame: frame)
        colorsCollectionView.dataSource = self
        
        self.backgroundColor = .backgroundColor
        setSubView()
        setConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubView(){
        addSubview(scrollView)
        scrollView.addSubview(titleTextField)
        scrollView.addSubview(textView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(colorsCollectionView)
        scrollView.addSubview(albumButtonBackground)
        scrollView.addSubview(albumButton)
    }
    private func setConstraints(){
        let centerX = ScreenSize.centerX.value
        //let centerY = ScreenSize.centerY.value
        
        //       let colorViewCenterY = colorView.frame.height * 0.5
        //      let colorViewSpaceX = colorView.frame.width * 0.075
        titleTextField.center = CGPoint(
            x: centerX,
            y: space * 2)
        textView.center = CGPoint(
            x: centerX,
            y: titleTextField.frame.maxY + space + textView.frame.height * 0.5)
        
        colorsCollectionView.center = CGPoint(
            x: centerX,
            y: imageView.frame.maxY + space + colorsCollectionView.frame.height * 0.5)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(space)
            make.width.equalTo(textView.snp.width)
       //     make.height.equalTo(imageView.snp.width)
            make.height.equalTo(60)
            make.centerX.equalTo(textView.snp.centerX)
        }
        colorsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(space)
            make.centerX.equalTo(textView)
            make.width.equalTo(imageView)
            make.height.equalTo(colorsCollectionView.snp.width).multipliedBy(0.2)
        }
        albumButtonBackground.snp.makeConstraints { (make) in
            make.right.equalTo(imageView).offset(-10)
            make.bottom.equalTo(imageView).offset(-10)
            make.height.equalTo(imageView).multipliedBy(0.1)
            make.width.equalTo(imageView).multipliedBy(0.1)
        }
        albumButton.snp.makeConstraints { (make) in
            make.height.left.right.bottom.equalTo(albumButtonBackground)
        }
    }
    func setUserData(data:TaskModel){
        if data.funtionType == .edit{
            addDeleteButton()
        }
        setImageView(image: data.image)
        // imageView.image = data.image
        titleTextField.text = data.title
        textView.text = data.description
        textView.resetHight(textView)
        self.selectColor = data.tag
    }
    func setImageView(image:UIImage?){
        func setUpNilImageView(){
            self.imageView.image = nil
            imageView.snp.updateConstraints{ (make) in
                make.height.equalTo(30)
            }
            albumButtonBackground.snp.remakeConstraints { (make) in
                make.top.bottom.left.right.equalTo(imageView)
            }
            albumButtonBackground.alpha = 0
        }
        func setUpImageView(){
            self.imageView.image = image
            imageView.snp.updateConstraints{ (make) in
                make.height.equalTo(300)
            }
            albumButtonBackground.snp.remakeConstraints { (make) in
                make.right.equalTo(imageView).offset(-10)
                make.bottom.equalTo(imageView).offset(-10)
                make.height.equalTo(imageView).multipliedBy(0.1)
                make.width.equalTo(imageView).multipliedBy(0.1)
            }
            albumButtonBackground.alpha = 1
        }

        if image != nil{
            setUpImageView()
            //resetHight(scrollView)
        }else{
            setUpNilImageView()
            //resetHight(scrollView)
        }
        
    }
    func refreshColor(color:ColorsButtonType){
        self.selectColor = color
    }
    func addDeleteButton(){
        let space = ScreenSize.spaceY.value
        addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (make) in
            make.top.equalTo(colorsCollectionView.snp.bottom).offset(space)
            make.centerX.equalTo(textView)
            make.width.equalTo(imageView)
            make.height.equalTo(deleteButton.snp.width).multipliedBy(0.2)
        }
    }
//    func resetHight(_ scrollView:UIScrollView){
//        let maxHeight:CGFloat = ScreenSize.height.value * 1.5
//        let minHeight:CGFloat = ScreenSize.height.value * 1.1
//        let itemsHeight =
//        titleTextField.frame.height +
//        textView.frame.height +
//        imageView.frame.height +
//        colorsCollectionView.frame.height * 2 +
//        space * 6
//        var height:CGFloat
//        if itemsHeight >= maxHeight{
//            height = maxHeight
//            scrollView.isScrollEnabled = true
//             print(0)
//        }else if itemsHeight < maxHeight && itemsHeight >= minHeight{
//            height = itemsHeight
//            scrollView.isScrollEnabled = true
//             print(1)
//        }else{
//            height = minHeight
//            scrollView.isScrollEnabled = false
//             print(2)
//        }
//
//        scrollView.contentSize.height = height
//        print(itemsHeight)
//        print(scrollView.contentSize.height)
//        print(minHeight)
//    }
}


extension CardEditView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ColorsButtonType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.cornerRadius = cell.frame.size.height * 0.5 
        let colorType = ColorsButtonType.allCases[indexPath.row]
        let color = colorType.color
        cell.backgroundColor = color
        if let selectColor = selectColor {
            if selectColor == colorType{
                cell.layer.borderColor = UIColor.white.cgColor
                cell.layer.borderWidth = 0.5
                cell.layer.masksToBounds = true
            }else{
                cell.layer.borderColor = UIColor.clear.cgColor
                cell.layer.borderWidth = 0.5
                cell.layer.masksToBounds = true
            }
        }
        return cell
        
    }
}


