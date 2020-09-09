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
            height: ScreenSize.height.value * 0.4))
        textView.layer.cornerRadius=5
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
    
    var colorsCollectionView:UICollectionView =
    {
        let viewWidth = ScreenSize.width.value * 0.7
        let allItemWidth = ScreenSize.height.value * 0.045 * 7
        let space = (viewWidth - allItemWidth) / 7
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ScreenSize.height.value * 0.045,
                                 height: ScreenSize.height.value * 0.045)
        layout.sectionInset = UIEdgeInsets(top: 0, left: space, bottom: 0, right: space);
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
        addSubview(scrollView)
        scrollView.addSubview(titleTextField)
        scrollView.addSubview(textView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(colorsCollectionView)
    }
    private func setConstraints(){
        let centerX = ScreenSize.centerX.value
        //let centerY = ScreenSize.centerY.value
        let space = ScreenSize.spaceY.value
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
            y: imageView.frame.maxY + space + colorView.frame.height * 0.5)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(space)
            make.width.equalTo(textView.snp.width)
            make.height.equalTo(imageView.snp.width)
            make.centerX.equalTo(textView.snp.centerX)
        }
        colorsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(space)
            make.centerX.equalTo(textView)
            make.width.equalTo(imageView)
            make.height.equalTo(colorsCollectionView.snp.width).multipliedBy(0.2)
        }
        

    }
    func setUserData(image:UIImage,title:String,script:String){
        imageView.image = image
        titleTextField.text = title
        textView.text = script
        textView.resetHight(textView)
    }
    
}


extension CardEditVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.cornerRadius = cell.frame.size.height * 0.5
        let color  : UIColor = {
            switch indexPath.row {
            case 0 :
                return UIColor.buttonRed
            case 1 :
                return UIColor.buttonOrange
            case 2 :
                return UIColor.buttonYello
            case 3 :
                return UIColor.buttonGreen
            case 4 :
                return UIColor.buttonBlue
            case 5 :
                return UIColor.button2u04
            case 6 :
                return UIColor.buttonPurple
            default:
                return UIColor.buttonRed
            }
        }()
        cell.backgroundColor = color
        return cell
    }
}



