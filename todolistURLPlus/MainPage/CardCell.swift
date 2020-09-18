//
//  CardCell.swift
//  todolistURLPlus
//
//  Created by Jimmy on 2020/9/7.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    lazy var cardTitle: UILabel =
    {
        let label = UILabel(frame: CGRect(x: self.frame.width * 0.1,
            y: self.frame.height * 0.7,
            width: self.frame.width * 0.9,
            height: self.frame.height * 0.2))
        label.layer.cornerRadius = self.frame.width * 0.8 * 0.05
        label.clipsToBounds = true
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var longPress: UILongPressGestureRecognizer =
    {
        let press = UILongPressGestureRecognizer(target: self, action: #selector(self.deleteCard))
        press.minimumPressDuration = 1.0
        return press
    }()
    lazy var deleteIndicator: UIButton =
        {
            let button = UIButton()
            button.center = CGPoint(x: 0, y: 0)
            
            button.frame.size = CGSize(width: self.frame.width * 0.2,
                                       height: self.frame.width * 0.2)
            button.setBackgroundImage(UIImage(systemName: "xmark.circle"), for: .normal)
            button.tintColor = .red
            
            button.isHidden = true
            return button
    }()
   
    @objc func deleteCard()
    {
        if longPress.state == .began
        {
            print("Cell的Frame = ",self.frame)
            print("press began")
            print("Delete Card")
            deleteIndicator.isHidden = false


        }else if longPress.state == .ended
        {
            print("long press end")

        }
    }
    func setUpSingle(showCards: [GetAllCardResponse.ShowCard], indexPath: IndexPath?)
    {
        if let indexPath = indexPath
        {
            let data = showCards[indexPath.row]
            self.backgroundColor = .clear
            self.layer.cornerRadius = self.frame.width * 0.05
            self.clipsToBounds = true
            self.cardTitle.text = data.cardName
            self.cardTitle.textColor = .white
            self.backgroundView = UIImageView(image: UIImage(named:"blueCard"))
            self.addSubview(cardTitle)
            self.addGestureRecognizer(longPress)
            self.addSubview(deleteIndicator)
        }
    }
    
    func setUpMutiple(cardDatas: [CardModel]?, indexPath: IndexPath?)
       {
        
        
           if let cardDatas = cardDatas, let indexPath = indexPath
           {
               let data = cardDatas[indexPath.row]
               self.backgroundColor = .clear
               self.layer.cornerRadius = self.frame.width * 0.05
               self.clipsToBounds = true
               self.cardTitle.text = data.cardTitle
               self.cardTitle.textColor = .white
               self.backgroundView = UIImageView(image: UIImage(named:"redCard"))
               self.addSubview(cardTitle)
           }
       }
}
