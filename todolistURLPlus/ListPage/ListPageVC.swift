//
//  ListPageVC.swift
//  todolistURLPlus
//
//  Created by Jimmy on 2020/9/9.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class ListPageVC: UIViewController {
    let backgroundImage:UIImageView = {
        return BackGroundFactory.makeImage(type: .background2)
    }()
    lazy var bottomOfNaviBar = navigationController?.navigationBar.frame.maxY ?? 0
    lazy var cardTitleLabel: UILabel =
        {
            let label = UILabel()
            label.frame = CGRect(x: ScreenSize.width.value * 0.05,
                                 y: self.bottomOfNaviBar * 1.25,
                                 width: ScreenSize.width.value,
                                 height: ScreenSize.height.value * 0.1)
            label.text = "How to get a girlfriend"
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.textColor = .white
            return label
    }()
//    lazy var creatBtn: UIButton =
//    {
//        let btn = UIButton()
//        let height = (ScreenSize.height.value - self.singleCardCollectionView.frame.maxY) * 0.8
//        btn.frame = CGRect(x: ScreenSize.width.value * 0.25,
//                           y: self.singleCardCollectionView.frame.maxY,
//                           width: ScreenSize.width.value * 0.5,
//                           height: height)
//        btn.backgroundColor = .clear
//        btn.setTitle("Creat a new card", for: .normal)
//        btn.setTitleColor(.black, for: .normal)
//        btn.contentHorizontalAlignment = .center
//        btn.contentVerticalAlignment = .center
//        btn.titleLabel?.adjustsFontSizeToFitWidth = true
//        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
//        btn.addTarget(self, action: #selector(self.creatNewCard), for: .touchDown)
//        return btn
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        // Do any additional setup after loading the view.
    }
    
func addSubview()
{
    self.view.addSubview(backgroundImage)
    self.view.addSubview(cardTitleLabel)
    }

}
