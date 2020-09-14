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
    func setUpSingle(cardDatas: [MainModel]?, indexPath: IndexPath?)
    {
        if let cardDatas = cardDatas, let indexPath = indexPath
        {
            let data = cardDatas[indexPath.row]
            self.backgroundColor = .clear
            self.layer.cornerRadius = self.frame.width * 0.05
            self.clipsToBounds = true
            self.cardTitle.text = data.cardTitle
            self.cardTitle.textColor = .white
            self.backgroundView = UIImageView(image: UIImage(named:"blueCard"))
            self.addSubview(cardTitle)
        }
    }
    
    func setUpMutiple(cardDatas: [MainModel]?, indexPath: IndexPath?)
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
