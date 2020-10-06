//
//  CardCell.swift
//  todolistURLPlus
//
//  Created by Jimmy on 2020/9/7.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    let fontName = "Reeji-CloudKaiXing-GB-Regular"
    lazy var cardTitle: UILabel =
    {
        let label = UILabel(frame: CGRect(x: self.frame.width * 0.1,
            y: self.frame.height * 0.1,
            width: self.frame.width * 0.8,
            height: self.frame.height * 0.8))
        label.layer.cornerRadius = self.frame.width * 0.8 * 0.05
        label.font = UIFont(name: self.fontName, size: self.frame.width * 0.2)
        label.clipsToBounds = true
        label.textAlignment = .left
        label.numberOfLines = 0
        

        return label
    }()
    lazy var cardID: UILabel =
    {
        let label = UILabel(frame: CGRect(x: self.frame.width * 0.1,
            y: self.frame.height * 0.1,
            width: self.frame.width * 0.8,
            height: self.frame.height * 0.8))
        label.layer.cornerRadius = self.frame.width * 0.8 * 0.05
        label.font = UIFont(name: self.fontName, size: self.frame.width * 0.15)
//        label.font = 
        label.clipsToBounds = true
        label.textAlignment = .left
        label.numberOfLines = 0
        

        return label
    }()
    lazy var cardState: UILabel =
    {
        let label = UILabel(frame: CGRect(x: self.frame.width * 0.1,
            y: self.frame.height * 0.1,
            width: self.frame.width * 0.8,
            height: self.frame.height * 0.8))
        label.layer.cornerRadius = self.frame.width * 0.8 * 0.05
        label.font = UIFont(name: self.fontName, size: self.frame.width * 0.15)
        label.clipsToBounds = true
        label.textAlignment = .left
        label.numberOfLines = 0
        

        return label
    }()
    lazy var myBackgroundView : UIView =
    {
        let view = GlassFactory.makeGlass(style: .systemUltraThinMaterial)
        view.layer.borderWidth = 0.2
        view.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.alpha = 1
        return view
    }()
    lazy var longPress: UILongPressGestureRecognizer =
    {
        let press = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressAction))
        press.minimumPressDuration = 1.0
        return press
    }()
    var deleteButton: UIImageView =
        {
            let imageView = UIImageView()
            imageView.center = CGPoint(x: 10, y: 10)
            imageView.frame.size = CGSize(width: ScreenSize.width.value * 0.15,
                                       height: ScreenSize.width.value * 0.15)

            imageView.image = UIImage(systemName: "xmark.circle")
            imageView.isHidden = true
            imageView.tintColor = .red

            return imageView
    }()
    
    lazy var backgroundCard:UIView = {
       var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    var buttonTag = 0

    
   var deleteButtonIsHidden = true
    @objc func longPressAction()
    {
        if longPress.state == .began
        {
            
            feedbackGenerator.impactOccurred()

            deleteButtonIsHidden = false
            deleteButton.isHidden = deleteButtonIsHidden

        }else if longPress.state == .ended
        {
            print("long press end")

        }
        
    }
   @objc func btnTag()
      {
        print(self.deleteButton.tag,"||",self.buttonTag)
        
      }
    
    func setupSingle(showCards: [GetCardResponse.ShowCard], indexPath: IndexPath?, state: Bool)
    {
        
        if let indexPath = indexPath
        {
            
            let data = showCards[indexPath.row]
            self.layer.cornerRadius = self.frame.width * 0.05
            self.clipsToBounds = true
//            self.cardTitle.text = """
//            \(data.id)\n\(data.cardName)\n\(data.cardPrivate)\n
//            """
            self.cardTitle.text = "\(data.cardName)"
            self.cardID.text = "\(data.id)"
            self.cardState.text = "\(data.cardPrivate)"
            
 //           self.cardTitle.textColor = .red
//            self.backgroundColor = .lightGray
            //let view = UIImageView(image: UIImage(named: "blueCard"))
            self.backgroundView = myBackgroundView
            self.backgroundCard.backgroundColor = .mainColorGlass
            self.backgroundCard.backgroundColor = .white
            self.deleteButton.isHidden = state
            
            self.addSubview(backgroundCard)
            backgroundCard.addSubview(cardTitle)
            backgroundCard.addSubview(cardID)
            backgroundCard.addSubview(cardState)
            
            self.addGestureRecognizer(longPress)
            setConstraints()

            self.addSubview(deleteButton)
        }
    }
    
    func setupMutiple(showCards: [GetCardResponse.ShowCard], indexPath: IndexPath?, state: Bool)
        {
            
            if let indexPath = indexPath
            {
                let data = showCards[indexPath.row]
                self.layer.cornerRadius = self.frame.width * 0.05
                self.clipsToBounds = true
//                self.cardTitle.text = "\(data.id)**\(data.cardName)**\(data.cardPrivate)"
                
                self.cardTitle.text = "\(data.cardName)"
                self.cardID.text = "\(data.id)"
                self.cardState.text = "\(data.cardPrivate)"
                
                //self.cardTitle.textColor = .red
                self.deleteButton.isHidden = state
                self.backgroundView = myBackgroundView
                self.backgroundCard.backgroundColor = .gray
                self.addSubview(backgroundCard)
                backgroundCard.addSubview(cardTitle)
                backgroundCard.addSubview(cardID)
                backgroundCard.addSubview(cardState)
                self.addGestureRecognizer(longPress)
                
                self.addSubview(deleteButton)
                setConstraints()
            }
        }
    func setConstraints(){
        backgroundCard.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
          //  make.height.equalToSuperview().multipliedBy(0.9)
        }
        cardTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.equalToSuperview()
        }
        cardID.snp.makeConstraints { (make) in
            make.top.equalTo(cardTitle.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.width.equalToSuperview()
        }
        cardState.snp.makeConstraints { (make) in
            make.top.equalTo(cardID.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.width.equalToSuperview()
        }
    }
}
