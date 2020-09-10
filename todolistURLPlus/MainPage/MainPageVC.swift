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
            let bottomOfNaviBar = navigationController?.navigationBar.frame.maxY ?? 0
            head.frame = CGRect(x: 0, y: bottomOfNaviBar, width: head.frame.width, height: head.frame.height)
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapToProfileSetting))
            head.addGestureRecognizer(tap)
            head.isUserInteractionEnabled = true
            return head
    }()
    ///設置歡迎標籤
    lazy var welcomeLabel: UILabel =
        {
            let label = UILabel()
            label.frame = CGRect(x: 0,
                                 y: self.headImage.frame.maxY,
                                 width: ScreenSize.width.value,
                                 height: self.headImage.frame.height * 0.4)
            label.text = "Welcome back \(self.userName)"
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.textColor = .white
            return label
    }()
    //按下按鈕的標籤值
    var btnTag = 0
    //點擊單人按鈕附加打勾圖案
    lazy var singleCheckMark: UIImageView =
    {
        let imageView = UIImageView(image: UIImage(named: "checkMark"))
        let x = ScreenSize.width.value * 0.2
        let y = (self.mutipleCardCollectionView.frame.minY - self.welcomeLabel.frame.maxY) * 0.25 + self.welcomeLabel.frame.maxY
        let width = ScreenSize.width.value * 0.15 * 0.5
        let height = ScreenSize.height.value * 0.1 * 0.5
        imageView.frame = CGRect(
            x: x,
            y: y,
            width: width,
            height: height)
        
        return imageView
    }()
    
    //點擊雙人按鈕附加打勾圖案
    lazy var mutipleCheckMark: UIImageView =
       {
           let imageView = UIImageView(image: UIImage(named: "checkMark"))
           let x = ScreenSize.width.value * 0.55
           let y = (self.mutipleCardCollectionView.frame.minY - self.welcomeLabel.frame.maxY) * 0.25 + self.welcomeLabel.frame.maxY
           let width = ScreenSize.width.value * 0.15 * 0.5
           let height = ScreenSize.height.value * 0.1 * 0.5
           imageView.frame = CGRect(
               x: x,
               y: y,
               width: width,
               height: height)
           
           imageView.isHidden = true
           return imageView
       }()
    
    //單人模式的按鈕
    lazy var singleBtn: UIButton = 
        {
            let button = UIButton()
            button.addTarget(self, action: #selector(self.tapSingleBtn), for: .touchDown)
//            button.setBackgroundImage(UIImage(systemName: "person"), for: .normal)
            button.setImage(UIImage(systemName: "person"), for: .normal)
//           
            button.tintColor = .white
            button.backgroundColor = .lightGray
            button.setTitle("Personal", for: .normal)
//            button.titleLabel?.contentMode = .bottom
            
//
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.font = UIFont.systemFont(ofSize: 60)
            button.setTitleColor(.red, for: .normal)
            button.frame = CGRect(x: ScreenSize.width.value * 0.2,
                                  y: (self.mutipleCardCollectionView.frame.minY - self.welcomeLabel.frame.maxY) * 0.25 + self.welcomeLabel.frame.maxY,
                                  width: ScreenSize.width.value * 0.2,
                                  height: ScreenSize.width.value * 0.2)
//            button.titleEdgeInsets = UIEdgeInsets(top: 0,
//                                                  left: 0,
//                                                  bottom: -button.frame.height * 0.85,
//                                                  right: 0)
            
            button.imageEdgeInsets = UIEdgeInsets(top: -20, left: 0, bottom: 20, right: 0)
//
            button.layer.cornerRadius = ScreenSize.width.value * 0.05
            button.clipsToBounds = true
            return button
    }()
    
    //雙人模式的按鈕
    lazy var mutipleBtn: UIButton =
        {
            let button = UIButton()
            button.addTarget(self, action: #selector(self.tapMutipleBtn), for: .touchDown)
            
            button.setBackgroundImage(UIImage(systemName: "person.3"), for: .normal)
            button.setTitle("多人模式", for: .normal)
            button.tintColor = .white
            
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.font = UIFont.systemFont(ofSize: 60)
            button.setTitleColor(.white, for: .normal)
            button.frame = CGRect(x: ScreenSize.width.value * 0.55,
                                  y: (self.mutipleCardCollectionView.frame.minY - self.welcomeLabel.frame.maxY) * 0.25 + self.welcomeLabel.frame.maxY,
                                  width: ScreenSize.width.value * 0.25,
                                  height: ScreenSize.width.value * 0.2)
            
            
            button.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                  left: 0,
                                                  bottom: -button.frame.height * 0.85,
                                                  right: 0)
            return button
    }()
    ///設置卡片(collectionView)
    var singleCardCollectionView: UICollectionView!
    var mutipleCardCollectionView: UICollectionView!
    
    lazy var creatBtn: UIButton =
    {
        let btn = UIButton()
        let height = (ScreenSize.height.value - self.singleCardCollectionView.frame.maxY) * 0.8
        btn.frame = CGRect(x: ScreenSize.width.value * 0.25,
                           y: self.singleCardCollectionView.frame.maxY,
                           width: ScreenSize.width.value * 0.5,
                           height: height)
        btn.backgroundColor = .clear
        btn.setTitle("Creat a new card", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.contentVerticalAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        btn.addTarget(self, action: #selector(self.creatNewCard), for: .touchDown)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }


    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    //MARK: collectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return 5
        default:
            
            return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case singleCardCollectionView:
            let singleCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.singleCell.identifier , for: indexPath) as! CardCell
            singleCell.setUp()
            singleCell.title.text = "123"
            singleCell.backgroundView = UIImageView(image: UIImage(named:"blueCard"))
            
            return singleCell
        default:
            let mutipleCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.mutipleCell.identifier, for: indexPath) as! CardCell
            mutipleCell.setUp()
            mutipleCell.backgroundView = UIImageView(image: UIImage(named:"redCard"))
            
            return mutipleCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = CardEditVC()
//        let taskData = TaskData( title:"This is Joey",
//                                 script: "I am Jimmy ,English is a West Germanic language first spoken in early medieval England and eventually became a global lingua franca. It is named after the Angles, one of,English is a West Germanic language first spoken in early medieval England and eventually became a global lingua franca. It is named after ",
//                                 image: UIImage(named: "joey"),
//                                 color: .blue)
//        vc.setTaskData(data: taskData)
        let vc = ListPageVC()
        present(vc, animated: true, completion: nil)
    }
    ///設定卡片CollectionView
    func setUpSingleCardCollectionView()
    {

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        // section與section之間的距離(如果只有一個section，可以想像成frame)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)

        // cell的寬、高
        layout.itemSize = CGSize(width: (ScreenSize.width.value) * 0.75,
                                 height: ScreenSize.height.value * 0.45)

        // cell與cell的間距
        layout.minimumLineSpacing = CGFloat(integerLiteral: Int(ScreenSize.width.value * 0.05))

        // cell與邊界的間距
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 10)

        // 滑動方向預設為垂直。注意若設為垂直，則cell的加入方式為由左至右，滿了才會換行；若是水平則由上往下，滿了才會換列
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal

        //設定collectionView的大小
        self.singleCardCollectionView = UICollectionView(frame: CGRect(
            x: 0,
            y: (ScreenSize.height.value * 0.4),
            width: ScreenSize.width.value ,
            height: (ScreenSize.height.value * 0.5)),
                                                         collectionViewLayout: layout)
        self.singleCardCollectionView.dataSource = self
        self.singleCardCollectionView.delegate = self
        self.singleCardCollectionView.register(CardCell.self, forCellWithReuseIdentifier: "singleCell")

        self.singleCardCollectionView.backgroundColor = .clear
        self.view.addSubview(singleCardCollectionView)
    }
    func setUpMutipleCardCollectionView()
    {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        // section與section之間的距離(如果只有一個section，可以想像成frame)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)

        // cell的寬、高
        layout.itemSize = CGSize(width: (ScreenSize.width.value) * 0.75,
                                 height: ScreenSize.height.value * 0.45)

        // cell與cell的間距
        layout.minimumLineSpacing = CGFloat(integerLiteral: Int(ScreenSize.width.value * 0.05))

        // cell與邊界的間距
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 10)

        // 滑動方向預設為垂直。注意若設為垂直，則cell的加入方式為由左至右，滿了才會換行；若是水平則由上往下，滿了才會換列
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal

        //設定collectionView的大小
        self.mutipleCardCollectionView = UICollectionView(frame: CGRect(
            x: 0,
            y: (ScreenSize.height.value * 0.4),
            width: ScreenSize.width.value ,
            height: (ScreenSize.height.value * 0.5)),
                                                          collectionViewLayout: layout)
        self.mutipleCardCollectionView.dataSource = self
        self.mutipleCardCollectionView.delegate = self
        self.mutipleCardCollectionView.register(CardCell.self, forCellWithReuseIdentifier: "mutipleCell")
        self.mutipleCardCollectionView.backgroundColor = .clear
        self.mutipleCardCollectionView.isHidden = true
        self.view.addSubview(mutipleCardCollectionView)
    }
    func setUI()
    {
        self.view.addSubview(backgroundImage)
        self.view.addSubview(headImage)
        self.view.addSubview(welcomeLabel)
        setUpMutipleCardCollectionView()
        setUpSingleCardCollectionView()
        self.view.addSubview(singleBtn)
        self.view.addSubview(mutipleBtn)
        self.view.addSubview(singleCheckMark)
        self.view.addSubview(mutipleCheckMark)
        self.view.addSubview(creatBtn)
    }
    //增加點擊手勢觸發跳轉個人資料設定
    @objc func tapToProfileSetting()
    {
        let vc = UserInfoVC()
        present(vc, animated: true, completion: nil)
    }
    

    @objc func tapSingleBtn()
    {
        
        mutipleCheckMark.isHidden = true
        btnTag = 0
        singleCardCollectionView.isHidden = false
        mutipleCardCollectionView.isHidden = true
        singleCheckMark.isHidden = false
        
    }
    @objc func tapMutipleBtn()
    {
        btnTag = 1
        mutipleCheckMark.isHidden = false
        singleCheckMark.isHidden = true
        singleCardCollectionView.isHidden = true
        mutipleCardCollectionView.isHidden = false
        
    }
    
    @objc func creatNewCard()
    {
        print("點擊按鈕新增卡片的方法，還沒寫，在\(#line)行")
    }
}




enum CollectionViewCellIdentifier: String
{
    case singleCell, mutipleCell
    var identifier: String
    {
        switch self
        {
        case .singleCell: return "singleCell"
        case .mutipleCell: return "mutipleCell"
        }
    }
}

#warning("這邊GET Card")
func getCard(){
    let a = ["userToken":UserToken.shared.userToken]
    let request = HTTPRequest(endpoint: .card, method: .GET, headers: a)
    NetworkManager().sendRequest(with: request.send()) { (result:Result<CardResponse,NetworkError>) in
        switch result {
            
        case .success(let data):
            print(data)//這裡是成功解包的東西 直接拿data裡的東西
            // data.cardData........
        case .failure(let err):
            print(err)
        }
    }
}
