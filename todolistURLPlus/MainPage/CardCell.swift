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
            y: self.frame.height * 0.1,
            width: self.frame.width * 0.8,
            height: self.frame.height * 0.8))
        label.layer.cornerRadius = self.frame.width * 0.8 * 0.05
        label.font = UIFont(name: "HanyiSentyZhangjizhi", size: self.frame.width * 0.15)
        label.clipsToBounds = true
        label.textAlignment = .center
        label.numberOfLines = 0
        

        return label
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
            self.cardTitle.text = """
            \(data.id)\n\(data.cardName)\n\(data.cardPrivate)\n
            """
            self.cardTitle.textColor = .red
//            self.backgroundColor = .lightGray
            let view = UIImageView(image: UIImage(named: "blueCard"))
            view.alpha = 0.5
            self.backgroundView = view
            self.deleteButton.isHidden = state
            self.addSubview(cardTitle)
            self.addGestureRecognizer(longPress)
          

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
                self.cardTitle.text = "\(data.id)**\(data.cardName)**\(data.cardPrivate)"
                self.cardTitle.textColor = .red
                self.backgroundColor = .lightGray
                self.deleteButton.isHidden = state
                self.addSubview(cardTitle)
                self.addGestureRecognizer(longPress)
                self.addSubview(deleteButton)
            }
        }
}
