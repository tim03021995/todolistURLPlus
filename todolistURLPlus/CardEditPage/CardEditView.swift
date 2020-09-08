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

    var colorsCollectionView:UICollectionView =
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10) // section與section之間的距離(如果只有一個section，可以想像成frame)
        layout.itemSize = CGSize(width: ScreenSize.height.value * 0.045,
                                 height: ScreenSize.height.value * 0.045) // cell的寬、高
        layout.minimumLineSpacing = CGFloat(integerLiteral: Int(ScreenSize.width.value * 0.02))
        // 滑動方向為「垂直」的話即「上下」的間距;滑動方向為「平行」則為「左右」的間距
        
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 10) // 滑動方向為「垂直」的話即「左右」的間距;滑動方向為「平行」則為「上下」的間距
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal // 滑動方向預設為垂直。注意若設為垂直，則cell的加入方式為由左至右，滿了才會換行；若是水平則由上往下，滿了才會換列
        let view = UICollectionView(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenSize.width.value * 0.7,
            height: ScreenSize.height.value * 0.1),
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
        addSubview(titleTextField)
        addSubview(textView)
        addSubview(imageView)
        //        addSubview(colorView)
        //        colorView.addSubview(colorButtonRed)
        //        colorView.addSubview(colorButtonOrange)
        //        colorView.addSubview(colorButtonYello)
        //        colorView.addSubview(colorButtonGreen)
        //        colorView.addSubview(colorButtonBlue)
        //        colorView.addSubview(colorButtonDarkBlue)
        //        colorView.addSubview(colorButtonPurple)
        addSubview(colorsCollectionView)
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

        colorsCollectionView.center = CGPoint(
            x: centerX,
            y: imageView.frame.maxY + space + colorView.frame.height * 0.5)
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
class CellOfColorsScrollView:UITableViewCell{
    
}
extension CardEditVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.frame = CGRect(
//            x: 0,
//            y: 0,
//            width: ScreenSize.height.value * 0.045,
//            height: ScreenSize.height.value * 0.045)
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        show(CardEditVC(), sender: nil)
    }
}
