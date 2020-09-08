//
//  MainPageVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
import SnapKit

class MainPageVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
   
    
    ///設置背景
    let userName = ""
    let backgroundImage:UIImageView = {
        return BackGroundFactory.makeImage(type: .background2)
    }()
    ///設置頭貼
    lazy var headImage: UIImageView =
    {
        let head = UserImageFactory.makeImageView(size: .small, image: nil)
        head.backgroundColor = .gray
        let nvBottom = navigationController?.navigationBar.frame.maxY
        let space = 15
        head.center = CGPoint(
            x: space + Int(head.frame.width * 0.5),
            y: Int(nvBottom!) + space + Int(head.frame.width * 0.3)
        )
        return head
    }()
    ///設置歡迎標籤
    lazy var welcomeLabel: UILabel =
    {
       let label = UILabel()
        label.frame = CGRect(x: ScreenSize.width.value * 0.05,
                             y: self.headImage.frame.maxY * 1.05,
                             width: ScreenSize.width.value * 0.9,
                             height: self.headImage.frame.height  * 0.8)
        label.text = "Welcome back \(self.userName)"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    ///設置卡片(collectionView)
    var cardCollectionView: UICollectionView!
//        {
//       let myCollectionView =
//        UICollectionView(frame: CGRect(
//        x: ScreenSize.width.value * 0.05,
//        y: (ScreenSize.hight.value * 0.6),
//        width: (ScreenSize.width.value * 0.7) ,
//        height: (ScreenSize.hight.value * 0.4)))
//            myCollectionView.backgroundColor = .yellow
//            self.cardCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//
//            return myCollectionView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(backgroundImage)
        self.view.addSubview(headImage)
        self.view.addSubview(welcomeLabel)
        
        setUpCollectionView()
        self.view.addSubview(cardCollectionView)

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        show(CardEditVC(), sender: nil)
        present(CardEditVC(), animated: true, completion: nil)
    }
    func setUpCollectionView()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // section與section之間的距離(如果只有一個section，可以想像成frame)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        
        // cell的寬、高
        layout.itemSize = CGSize(width: (ScreenSize.width.value) * 0.75,
                                 height: ScreenSize.hight.value * 0.45)
        
        //cell與cell間距
        layout.minimumLineSpacing = CGFloat(integerLiteral: Int(ScreenSize.width.value * 0.02))
        
        // cell與邊界的間距
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 10)
        // 滑動方向預設為垂直。注意若設為垂直，則cell的加入方式為由左至右，滿了才會換行；若是水平則由上往下，滿了才會換列
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        self.cardCollectionView = UICollectionView(frame: CGRect(
            x: 0,
            y: (ScreenSize.hight.value * 0.4),
            width: ScreenSize.width.value ,
            height: (ScreenSize.hight.value * 0.5)),
                                                   collectionViewLayout: layout)
        self.cardCollectionView.dataSource = self
        self.cardCollectionView.delegate = self
        self.cardCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.cardCollectionView.backgroundColor = .clear
        self.view.addSubview(cardCollectionView)
    }
    }

