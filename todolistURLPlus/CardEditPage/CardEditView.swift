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
            width: ScreenSize.width.value * 0.8,
            height: ScreenSize.width.value * 0.8))
        imageView.layer.cornerRadius = imageView.frame.width * 0.05
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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
            y: imageView.frame.maxY + space + colorsCollectionView.frame.height * 0.5)
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
    func setUserData(image:UIImage,title:String,script:String,color:ColorsButtonType){
        imageView.image = image
        titleTextField.text = title
        textView.text = script
        textView.resetHight(textView)
        print(color)
        self.selectColor = color
    }
    
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
    func showBlurEffect() {
    //创建一个模糊效果
    let blurEffect = UIBlurEffect(style: .light)
    //创建一个承载模糊效果的视图
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.frame = CGRect(x: 0, y: 64, width: 100 , height:100)
    let label = UILabel(frame: CGRect(x: 10, y: 100, width: 100, height: 100))
    label.text = "bfjnecsjdkcmslc,samosacmsacdfvneaui"
    label.font = UIFont.boldSystemFont(ofSize: 30)
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = UIColor.white
    blurView.contentView.addSubview(label)
    addSubview(blurView)
    }
}



