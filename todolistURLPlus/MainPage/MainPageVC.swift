//
//  MainPageVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
import SnapKit

//點擊震動
let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)

class MainPageVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    //    var cardDatas = [CardModel]()
    var state = true
    var cell: CardCell! = nil
    var userData: GetCardResponse.UserData!
    var showCards = [GetCardResponse.ShowCard]()
    {
        didSet
        {
            singleCardCollectionView.reloadData()
        }
    }
    //    var indexPath: IndexPath!
    ///設置背景
    
    var userName: GetUserResponse!
    let backgroundImage:UIImageView = {
        return BackGroundFactory.makeImage(type: .backgroundBlurred)
    }()
    ///設置頭貼
    var headImage: UIImageView =
    {
        let head = UserImageFactory.makeImageView(size: .small, image: nil)
        head.backgroundColor = .gray
        head.isUserInteractionEnabled = true
        head.isHidden = true
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
            
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.textColor = .white
            return label
    }()
    ///設置垃圾桶
    let trashBtn: UIButton =
    {
        let btn = UIButton(frame: CGRect(x: ScreenSize.width.value * 0.75, y: ScreenSize.height.value * 0.05, width: ScreenSize.width.value * 0.15, height: ScreenSize.width.value * 0.15))
        btn.tintColor = .white
        btn.setBackgroundImage(UIImage(systemName: "trash.fill"), for: .normal)
        btn.addTarget(self, action: #selector(MainPageVC.editMode), for: .touchUpInside)
        return btn
    }()
    //切換作業模式按鈕的標籤值
    var btnTag = 0
    //點擊單人按鈕附加打勾圖案
    lazy var singleCheckMark: UIImageView =
        {
            let imageView = UIImageView(image: UIImage(named: "checkMark"))
            let x = ScreenSize.width.value * 0.20
            let y = (self.mutipleCardCollectionView.frame.minY - self.welcomeLabel.frame.maxY) * 0.25 +  self.welcomeLabel.frame.maxY
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
    
    //單人模式按鈕底圖
    lazy var singleBtnView: UIView =
        {
            let singleBtnView = UIView()
            singleBtnView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
            singleBtnView.layer.cornerRadius = 10
            singleBtnView.frame = CGRect(x: ScreenSize.width.value * 0.2,
                                         y: (self.mutipleCardCollectionView.frame.minY - self.welcomeLabel.frame.maxY) * 0.25 + self.welcomeLabel.frame.maxY,//0.25
                width: ScreenSize.width.value * 0.25,
                height: ScreenSize.width.value * 0.25)
            
            return singleBtnView
    }()
    
    //雙人模式按鈕底圖
    lazy var mutipleBtnView: UIView =
        {
            let mutipleBtnView = UIView()
            mutipleBtnView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
            mutipleBtnView.layer.cornerRadius = 10
            mutipleBtnView.frame = CGRect(x: ScreenSize.width.value * 0.55,
                                          y: (self.mutipleCardCollectionView.frame.minY - self.welcomeLabel.frame.maxY) * 0.25 + self.welcomeLabel.frame.maxY,
                                          width: ScreenSize.width.value * 0.25,
                                          height: ScreenSize.width.value * 0.25)
            
            return mutipleBtnView
    }()
    
    //單人模式的按鈕
    lazy var singleBtn: UIButton = 
        {
            
            let button = UIButton()
            button.addTarget(self, action: #selector(self.tapSingleBtn), for: .touchDown)
            button.setBackgroundImage(UIImage(systemName: "person"), for: .normal)
            button.setTitle("Personal", for: .normal)
            button.tintColor = .black
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            //            button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13)
            button.setTitleColor(.black, for: .normal)
            button.frame = CGRect(x: ScreenSize.width.value * 0.2,
                                  y: (self.mutipleCardCollectionView.frame.minY - self.welcomeLabel.frame.maxY) * 0.42 + self.welcomeLabel.frame.maxY, //0.33
                width: ScreenSize.width.value * 0.25,
                height: ScreenSize.width.value * 0.168) //0.15
            button.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                  left: 0,
                                                  bottom: -button.frame.height * 1.2, //0.85
                right: 0)
            
            //            button.imageEdgeInsets = UIEdgeInsets(top: -20, left: 0, bottom: 20, right: 0)
            //
            
            
            return button
    }()
    
    //雙人模式的按鈕
    lazy var mutipleBtn: UIButton =
        {
            let button = UIButton()
            button.addTarget(self, action: #selector(self.tapMutipleBtn), for: .touchDown)
            button.setBackgroundImage(UIImage(systemName: "person.3"), for: .normal)
            button.setTitle("Multiple", for: .normal)
            button.tintColor = .black
            
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            //            button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
            button.setTitleColor(.black, for: .normal)
            button.frame = CGRect(x: ScreenSize.width.value * 0.55,
                                  y: (self.mutipleCardCollectionView.frame.minY - self.welcomeLabel.frame.maxY) * 0.25 + self.welcomeLabel.frame.maxY,
                                  width: ScreenSize.width.value * 0.25,
                                  height: ScreenSize.width.value * 0.2)
            
            
            button.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                  left: 0,
                                                  bottom: -button.frame.height * 1.05,
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
    override func viewWillAppear(_ animated: Bool) {
        getCard()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        singleCardCollectionView.reloadData()
        welcomeLabel.text = "Welcome back \(self.userData.username)"
        setupHeadImage()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDataManager.shared.getUserData(email: userData.email) { (userData) in
            self.headImage.image = UserDataManager.shared.userImage
        }
        
        //        if UserToken.shared.userToken == "" {
        ////            let nc = storyboard?.instantiateViewController(withIdentifier: "LoginNC") as! UINavigationController
        //            let vc = LoginVC.instantiate()
        //
        //            present(vc, animated: true , completion: nil)
        //        }
        setUI()
    }
    
    
    
    
    
    //MARK: collectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case singleCardCollectionView :
            return showCards.count
        default:
            return 2
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case singleCardCollectionView:
            //            self.indexPath = indexPath
            
            let singleCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.singleCell.identifier , for: indexPath) as! CardCell
            
            self.cell = singleCell
            singleCell.setUpSingle(showCards: showCards, indexPath: indexPath)
            
            
            singleCell.deleteButton.isHidden = state
            singleCell.deleteButton.tag = indexPath.row
            
            
            return singleCell
        default:
            let mutipleCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.mutipleCell.identifier, for: indexPath) as! CardCell
            
            
            return mutipleCell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !state
        {
            deleteCard(indexPath: indexPath)
            
        }else
        {
            toListPageVC(indexPath: indexPath)
        }
        
        singleBtn.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).priority(.medium)
        }
        
        
    }
    
    fileprivate func toListPageVC(indexPath: IndexPath) {
        let lPVC = ListPageVC()
        let nVC = UINavigationController(rootViewController: lPVC)
        //        lPVC.cardData = cardDatas[indexPath.row]
        lPVC.showCard = showCards[indexPath.row]
        lPVC.cardIndexPath = indexPath
        feedbackGenerator.impactOccurred()
        
        present(nVC, animated: true, completion: nil)
        
    }
    fileprivate func getHeadImage() {
        if let imageString = userData.image
        {
            if let imageUrl = URL(string: "http://35.185.131.56:8002/" + imageString)
            {
                do
                {
                    if let imageData = try? Data(contentsOf: imageUrl)
                    {
                        if let image = UIImage(data: imageData)
                        {
                            headImage.image = image
                        }
                    }
                }catch
                {
                    print("Image轉型失敗，MainPageVC ",#line)
                }
            }
        }
    }
    
    func setupHeadImage()
    {
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        headImage.frame = CGRect(x: 0, y: statusBarHeight * 1.5, width: headImage.frame.width, height: headImage.frame.height)
        headImage.isHidden = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapToProfileSetting))
        headImage.addGestureRecognizer(tap)
        getHeadImage()
        
    }
    
    //blueconstraints 讓btn和灰色左右底部固定距離，高度隨比例更動
    func setSingleBtnConstraints(){
        singleBtn.translatesAutoresizingMaskIntoConstraints = false
        singleBtn.centerXAnchor.constraint(equalTo: singleBtnView.centerXAnchor).isActive = true
        singleBtn.bottomAnchor.constraint(equalTo: singleBtnView.bottomAnchor,constant: -17).isActive = true
        singleBtn.heightAnchor.constraint(equalTo: singleBtnView.heightAnchor, multiplier: 0.67).isActive = true //0.67
        singleBtn.leadingAnchor.constraint(equalTo: singleBtnView.leadingAnchor, constant: 10).isActive = true
        singleBtn.trailingAnchor.constraint(equalTo: singleBtnView.trailingAnchor, constant: -10 ).isActive = true
        
        
        //        singleBtn.translatesAutoresizingMaskIntoConstraints = false
        //        singleBtn.centerXAnchor.constraint(equalTo: singleBtnView.centerXAnchor).isActive = true
        //        singleBtn.bottomAnchor.constraint(equalTo: singleBtnView.bottomAnchor,constant: -17).isActive = true
        //        singleBtn.heightAnchor.constraint(equalTo: singleBtnView.heightAnchor, multiplier: 0.67).isActive = true
        //        singleBtn.leadingAnchor.constraint(equalTo: singleBtnView.leadingAnchor, constant: 0).isActive = true
        //        singleBtn.trailingAnchor.constraint(equalTo: singleBtnView.trailingAnchor, constant: 0 ).isActive = true
    }
    
    
    //redconstraints 讓btn和灰色左右底部固定距離，高度隨比例更動
    func setMutipleBtnConstraints(){
        mutipleBtn.translatesAutoresizingMaskIntoConstraints = false
        mutipleBtn.centerXAnchor.constraint(equalTo: mutipleBtnView.centerXAnchor).isActive = true
        mutipleBtn.bottomAnchor.constraint(equalTo: mutipleBtnView.bottomAnchor,constant: -18).isActive = true
        mutipleBtn.heightAnchor.constraint(equalTo: mutipleBtnView.heightAnchor, multiplier: 0.67).isActive = true
        mutipleBtn.leadingAnchor.constraint(equalTo: mutipleBtnView.leadingAnchor, constant: 0).isActive = true
        mutipleBtn.trailingAnchor.constraint(equalTo: mutipleBtnView.trailingAnchor, constant: 0 ).isActive = true
    }
    
    //設定藍卡片的constraints
    func SetSingleCardCollectionView(){
        singleCardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        singleCardCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        singleCardCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 10).isActive = true
        singleCardCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.67).isActive = true
        singleCardCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        singleCardCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0 ).isActive = true
    }
    
    //設定紅卡片的constraints
    func SetMultipleCardCollectionView(){
        mutipleCardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mutipleCardCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mutipleCardCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 10).isActive = true
        mutipleCardCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.67).isActive = true
        mutipleCardCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mutipleCardCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0 ).isActive = true
    }
    
    @objc func editMode()
    {
        state = !state
        singleCardCollectionView.reloadData()
        trashBtn.tintColor = !state ? .red : .white
        
    }
    ///設定卡片CollectionView
    func setUpSingleCardCollectionView()
    {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        // section與section之間的距離(如果只有一個section，可以想像成frame) 沒影響
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        
        // cell的寬、高
        layout.itemSize = CGSize(width: (ScreenSize.width.value) * 0.75,
                                 height: ScreenSize.height.value * 0.45)
        
        // cell與cell的間距
        layout.minimumLineSpacing = CGFloat(integerLiteral: Int(ScreenSize.width.value * 0.05))
        
        // cell與邊界的間距 沒影響
        //        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 10)
        
        // 滑動方向預設為垂直。注意若設為垂直，則cell的加入方式為由左至右，滿了才會換行；若是水平則由上往下，滿了才會換列
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        //        設定collectionView的大小
        self.singleCardCollectionView = UICollectionView(frame: CGRect(
            x: 0,
            y: (ScreenSize.height.value * 0.4),   //
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
                                 height: ScreenSize.height.value * 0.45) //0.45
        
        // cell與cell的間距
        layout.minimumLineSpacing = CGFloat(integerLiteral: Int(ScreenSize.width.value * 0.05))
        
        // cell與邊界的間距
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 10) //10
        
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
        self.view.addSubview(singleBtnView)
        self.view.addSubview(mutipleBtnView)
        self.view.addSubview(singleBtn)
        self.view.addSubview(mutipleBtn)
        self.view.addSubview(singleCheckMark)
        self.view.addSubview(mutipleCheckMark)
        self.view.addSubview(creatBtn)
        self.view.addSubview(trashBtn)
        setSingleBtnConstraints()
        setMutipleBtnConstraints()
        
        SetSingleCardCollectionView()
        SetMultipleCardCollectionView()
        //        setAddEditorBtnConstrants()
        
    }
    
    //增加點擊手勢觸發跳轉個人資料設定
    @objc func tapToProfileSetting()
    {
        #warning("需要輸入 email")
        let vc = UserInfoVC(email: userData.email)
        let nc = UINavigationController(rootViewController: vc)
        //       vc.modalPresentationStyle = .overCurrentContext
        present(nc, animated: true, completion: nil)
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
    @objc func showDeleteButton()
    {
        state = !state
    }
    
    @objc func creatNewCard()
    {
        //        let dis = DispatchQueue.
        addCard {
            self.getCard()
        }
        
        
        //        DispatchQueue.sync(dis)
        //        self.cardDatas.append(CardModel(cardID: cardDatas.count))
        
        singleCardCollectionView.reloadData()
        //點擊觸發震動
        
        feedbackGenerator.impactOccurred()
    }
    
    func getCard(){
        let header = ["userToken":UserToken.shared.userToken]
        let request = HTTPRequest(endpoint: .card, contentType: .json, method: .GET, headers: header).send()
        NetworkManager.sendRequest(with: request) { (result:Result<GetCardResponse,NetworkError>) in
            switch result {
                
            case .success(let data):
                let showCards = data.userData.showCards
                let userData = data.userData
                self.userData = userData
                self.showCards = showCards
                print("讀取資料成功，目前資料有\(showCards.count)張卡片")
                self.singleCardCollectionView.reloadData()
                print("使用者照片 ＝", self.userData.image)
            case .failure(let err):
                print(err.description)
            }
        }
    }
    func addCard(complection:@escaping()->Void){ //新增card的API方法
        let header = ["userToken":UserToken.shared.userToken]
        //TODO 新增的card name
        let parameter = ["card_name":"新增的卡片"]
        
        let request = HTTPRequest(endpoint: .card, contentType: .json, method: .POST, parameters: parameter, headers: header).send()
        
        NetworkManager.sendRequest(with: request) { (result:Result<PostCardResponse,NetworkError>) in
            switch result{
                
            case .success(let data):
                print("目前新增的卡片ID = \(data.cardData.id)")
                complection()
                
            case .failure(let err):
                print("err.description = \(err.description)")
                print("err.errormessage = \(err.errMessage)")
            }
        }
    }
    @objc func buttonTag()
    {
        print(self.cell.deleteButton.tag)
    }
    func deleteCard(indexPath: IndexPath){
        let header = ["userToken":UserToken.shared.userToken]
        let request = HTTPRequest(endpoint: .card, contentType: .json, method: .DELETE, parameters: .none, headers: header, id: showCards[indexPath.row].id).send()
        
        NetworkManager.sendRequest(with: request) { (result:Result<DeleteCardResponse,NetworkError>) in
            switch result{
                
            case .success(let data):
                //                self.showCards.remove(at: self.indexPath.row)
                
                self.getCard()
                print("刪除成功，第",self.btnTag,"張卡片")
                
                
            case .failure(let err):
                print("err.description = \(err.description)")
                print("err.errormessage = \(err.errMessage)")
            }
        }
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






