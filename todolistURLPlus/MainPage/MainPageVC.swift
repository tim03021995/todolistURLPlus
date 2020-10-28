//
//  MainPageVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
import SnapKit
protocol RefreshDelegate: AnyObject {
    func refreshUserInfo()
    func refreshCardName()
}
// 全域變數點擊震動
let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)




class MainPageVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var loadingManager = LoadingManager()
    var showDeleteButtonState = true
    var cell: CardCell! = nil
    var userData: GetCardResponse.UserData!
    
    //所有卡片的陣列
    var showCards = [GetCardResponse.ShowCard]()
    {
        didSet
        {
            singleCardCollectionView.reloadData()
        }
    }
    
    //單人卡片的陣列
    var showSingleCards = [GetCardResponse.ShowCard]()
    {
        didSet
        {
            singleCardCollectionView.reloadData()
        }
    }
    
    //多人卡片的陣列
    var showMutipleCards = [GetCardResponse.ShowCard]()
    {
        didSet
        {
            mutipleCardCollectionView.reloadData()
        }
    }
    //儲存卡片是新增模式還是編輯模式進到下一頁的
    var cardStyle: TaskModel.FuntionType?
    
    //判斷第一次進來頁面
    var isFirstLoading = true
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
    lazy var trashBtn: UIButton =
        {
            let btn = UIButton(frame: CGRect(x: ScreenSize.width.value * 0.8, y: 50, width: ScreenSize.width.value * 0.15, height: ScreenSize.width.value * 0.15))
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
            button.addTarget(self, action: #selector(self.tapSingleBtn), for: .touchUpInside)
            button.setBackgroundImage(UIImage(systemName: "person"), for: .normal)
            button.setTitle("Personal", for: .normal)
            button.tintColor = .black
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            button.setTitleColor(.black, for: .normal)
            button.frame = CGRect(x: ScreenSize.width.value * 0.2,
                                  y: (self.mutipleCardCollectionView.frame.minY - self.welcomeLabel.frame.maxY) * 0.42 + self.welcomeLabel.frame.maxY, //0.33
                                  width: ScreenSize.width.value * 0.25,
                                  height: ScreenSize.width.value * 0.168) //0.15
            button.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                  left: 0,
                                                  bottom: -button.frame.height * 1.2, //0.85
                                                  right: 0)
            
            
            
            return button
        }()
    
    //雙人模式的按鈕
    lazy var mutipleBtn: UIButton =
        {
            let button = UIButton()
            button.addTarget(self, action: #selector(self.tapMutipleBtn), for: .touchUpInside)
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
            let btn = CustomButton()
            let height = (ScreenSize.height.value - self.singleCardCollectionView.frame.maxY) * 0.6
            btn.frame = CGRect(
                x: ScreenSize.width.value * 0.25,
                y:self.singleCardCollectionView.frame.maxY,
                width: ScreenSize.width.value * 0.5,
                height: height)
            btn.setTitle("Creat a new card", for: .normal)
            btn.backgroundColor = .mainColorGlass
            btn.setTitleColor(.white, for: .normal)
            btn.contentHorizontalAlignment = .center
            btn.contentVerticalAlignment = .center
            btn.titleLabel?.adjustsFontSizeToFitWidth = true
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            btn.layer.cornerRadius = btn.frame.height * 0.25
            btn.addTarget(self, action: #selector(self.creatNewCard), for: .touchUpInside)
            
            return btn
        }()
    
    let loadIndicatorView:UIActivityIndicatorView = {
        var loading = UIActivityIndicatorView()
        loading.center = CGPoint(x: ScreenSize.centerX.value, y: ScreenSize.centerY.value)
        loading.color = .white
        loading.style = .large
        
        return loading
    }()
    
    lazy var glass:UIView = {
        let view = UIView(frame: self.view.frame)
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let glassView = UIVisualEffectView(effect: blurEffect)
        glassView.frame = CGRect(x:0, y:0, width: ScreenSize.width.value, height: ScreenSize.height.value)
        glassView.alpha = 1
        view.addSubview(glassView)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
        setupHeadImage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        getCard()
    }
    
    
    //MARK: collectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case singleCardCollectionView :
            return showSingleCards.count
        default:
            return showMutipleCards.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case singleCardCollectionView:
            let singleCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.singleCell.identifier , for: indexPath) as! CardCell
            self.cell = singleCell
            singleCell.setupSingle(showCards: showSingleCards, indexPath: indexPath, state: showDeleteButtonState)
            return singleCell
        default:
            let mutipleCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.mutipleCell.identifier, for: indexPath) as! CardCell
            mutipleCell.setupMutiple(showCards: showMutipleCards, indexPath: indexPath, state: showDeleteButtonState)
            return mutipleCell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        loadingManager.startLoading(vc: self)
        if !showDeleteButtonState
        {
            startLoading()
            switch collectionView {
            case singleCardCollectionView:
                deleteCard(indexPath: indexPath, whichData: .single)
            default:
                deleteCard(indexPath: indexPath, whichData: .mutiple)
                
            }
            
        }else
        {
            switch collectionView {
            case singleCardCollectionView:
                toListPageVC(indexPathRow: indexPath.row, whichStyle: .single)
            default:
                toListPageVC(indexPathRow: indexPath.row, whichStyle: .mutiple)
            }
        }
    }
    
    
    fileprivate func toListPageVC(indexPathRow: Int, whichStyle: WhichCollectionView) {
        
        let lPVC = ListPageVC()
        lPVC.delegate = self
        
        let nVC = UINavigationController(rootViewController: lPVC)
        if whichStyle == .single
        {
            lPVC.showCard = showSingleCards[indexPathRow]
        }else
        {
            lPVC.showCard = showMutipleCards[indexPathRow]
        }
        feedbackGenerator.impactOccurred()
        
        present(nVC, animated: true, completion: nil)
        
    }
    
    fileprivate func getSingletonImage(userData: GetCardResponse.UserData) {
        self.loadingManager.startLoading(vc: self)
        UserDataManager.shared.getUserData(email: userData.email) { (image) in
            self.headImage.image = image
            self.stopLoading()
        }
    }
    func setupHeadImage()
    {
        headImage.frame = CGRect(x: ScreenSize.width.value * 0.05, y: trashBtn.frame.minY, width: headImage.frame.width, height: headImage.frame.height)
        headImage.isHidden = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapToProfileSetting))
        headImage.addGestureRecognizer(tap)
    }
    
    //blueconstraints 讓btn和灰色左右底部固定距離，高度隨比例更動
    func setSingleBtnConstraints(){
        singleBtn.translatesAutoresizingMaskIntoConstraints = false
        singleBtn.centerXAnchor.constraint(equalTo: singleBtnView.centerXAnchor).isActive = true
        singleBtn.bottomAnchor.constraint(equalTo: singleBtnView.bottomAnchor,constant: -17).isActive = true
        singleBtn.heightAnchor.constraint(equalTo: singleBtnView.heightAnchor, multiplier: 0.67).isActive = true //0.67
        singleBtn.leadingAnchor.constraint(equalTo: singleBtnView.leadingAnchor, constant: 10).isActive = true
        singleBtn.trailingAnchor.constraint(equalTo: singleBtnView.trailingAnchor, constant: -10 ).isActive = true
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
        showDeleteButtonState = !showDeleteButtonState
        singleCardCollectionView.reloadData()
        mutipleCardCollectionView.reloadData()
        let animate = UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
            self.trashBtn.tintColor = !self.showDeleteButtonState ? .red : .white
        }
        feedbackGenerator.impactOccurred()
        animate.startAnimation()
    }
    ///設定卡片CollectionView
    func setUpSingleCardCollectionView()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        // section與section之間的距離(如果只有一個section，可以想像成frame) 沒影響
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        
        // cell的寬、高
        layout.itemSize = CGSize(width: (ScreenSize.width.value) * 0.75,
                                 height: ScreenSize.height.value * 0.35)
        
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
                                 height: ScreenSize.height.value * 0.35) //0.45
        
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
    }
    
    //增加點擊手勢觸發跳轉個人資料設定
    @objc func tapToProfileSetting()
    {
        let vc = UserInfoVC(email: userData.email)
        vc.delegate = self
        let nc = UINavigationController(rootViewController: vc)
        feedbackGenerator.impactOccurred()
        present(nc, animated: true, completion: nil)
    }
    
    
    @objc func tapSingleBtn()
    {
        feedbackGenerator.impactOccurred()
        btnTag = 0
        let animate = UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
            self.mutipleCheckMark.alpha = 0
            self.singleCardCollectionView.alpha = 1
            self.mutipleCardCollectionView.alpha = 0
            self.singleCheckMark.alpha = 1
        }
        animate.startAnimation()
        singleCardCollectionView.reloadData()
    }
    @objc func tapMutipleBtn()
    {
        feedbackGenerator.impactOccurred()
        btnTag = 1
        self.mutipleCheckMark.isHidden = false
        self.singleCardCollectionView.isHidden = false
        self.mutipleCardCollectionView.isHidden = false
        self.singleCheckMark.isHidden = false
        let animate = UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
            self.mutipleCheckMark.alpha = 1
            self.singleCardCollectionView.alpha = 0
            self.mutipleCardCollectionView.alpha = 1
            self.singleCheckMark.alpha = 0
        }
        animate.startAnimation()
        mutipleCardCollectionView.reloadData()
        
    }
    
    @objc func creatNewCard()
    {
        addCard()
        singleCardCollectionView.reloadData()
        //點擊觸發震動
        feedbackGenerator.impactOccurred()
    }
    
    func classifiedSingleAndMutiple(showCards:[GetCardResponse.ShowCard])
    {
        self.showSingleCards = []
        self.showMutipleCards = []
        showCards.map { card in
            if card.cardPrivate
            {
                self.showSingleCards.append(card)
            }else
            {
                self.showMutipleCards.append(card)
            }
        }
    }
    
    func showNewestItem()
    {
        let cardPrivate = showCards[showCards.count - 1].cardPrivate
        if cardPrivate
        {
            let index = IndexPath(item: (self.showSingleCards.count - 1), section: 0)
            self.singleCardCollectionView.scrollToItem(at: index, at: .right, animated: true)
            self.singleCardCollectionView.isHidden = false
            self.mutipleCardCollectionView.isHidden = true
            self.singleCheckMark.isHidden = false
            self.mutipleCheckMark.isHidden = true
        }else
        {
            let index = IndexPath(item: (self.showMutipleCards.count - 1), section: 0)
            self.mutipleCardCollectionView.scrollToItem(at: index, at: .right, animated: true)
            self.mutipleCardCollectionView.isHidden = false
            self.singleCardCollectionView.isHidden = true
            self.singleCheckMark.isHidden = true
            self.mutipleCheckMark.isHidden = false
        }
    }
    
    func getCard(isAdd:Bool = false){
        
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        loadingManager.startLoading(vc: self)
        let header = ["userToken":token]
        let request = HTTPRequest(endpoint: .card, contentType: .json, method: .GET, headers: header).send()
        NetworkManager().sendRequest(with: request) { (result:Result<GetCardResponse,NetworkError>) in
            switch result {
            
            case .success(let data):
                let showCards = data.userData.showCards
                let userData = data.userData
                self.userData = userData
                self.showCards = showCards
                print("讀取資料成功，目前資料有\(showCards.count)張卡片")
                
                self.classifiedSingleAndMutiple(showCards: showCards)
                self.welcomeLabel.text = "Welcome back \(self.userData.username)"
                print("現在的使用者名稱", userData.username)
                self.singleCardCollectionView.reloadData()
                self.mutipleCardCollectionView.reloadData()
                if self.isFirstLoading
                {
                    self.getSingletonImage(userData: userData)
                    self.isFirstLoading = !self.isFirstLoading
                }
                if isAdd
                {
                    self.showNewestItem()
                    self.toListPageVC(indexPathRow: (self.showSingleCards.count - 1), whichStyle: .single)
                }else if self.cardStyle == .create
                {
                    self.showNewestItem()
                    self.cardStyle = nil
                }
                if !self.isFirstLoading {
                    self.loadingManager.stopLoading()
                }
            case .failure(let err):
                print(err.description)
                self.alertMessage(alertTitle: "發生錯誤", alertMessage: err.description, actionTitle: "稍後再試")
                self.loadingManager.startLoading429(vc: self)
                self.loadingManager.startLoading429(vc: self)
            }
            
            
        }
    }
    func addCard(){ //新增card的API方法
        //        let header = ["userToken":UserToken.shared.userToken]
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        self.loadingManager.startLoading(vc: self)
        let header = ["userToken":token]
        //TODO 新增的card name
        let parameter = ["card_name":"新增的卡片"]
        
        let request = HTTPRequest(endpoint: .card, contentType: .json, method: .POST, parameters: parameter, headers: header).send()
        
        NetworkManager().sendRequest(with: request) { (result:Result<PostCardResponse,NetworkError>) in
            switch result{
            
            case .success(let data):
                print("目前新增的卡片ID = \(data.cardData.id)")
                self.cardStyle = .create
                self.getCard(isAdd: true)
            case .failure(let err):
                print("err.description = \(err.description)")
                print("err.errormessage = \(err.errMessage)")
                self.alertMessage(alertTitle: "發生錯誤", alertMessage: err.description, actionTitle: "稍後再試")
                self.loadingManager.startLoading429(vc: self)
                self.loadingManager.startLoading429(vc: self)
            }
        }
    }
    
    func deleteCard(indexPath: IndexPath, whichData:WhichCollectionView){
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        let headers = ["userToken":token]
        
        let id: Int
        switch whichData {
        case .single:
            id = showSingleCards[indexPath.row].id
        default:
            id = showMutipleCards[indexPath.row].id
        }
        let request = HTTPRequest(endpoint: .card, contentType: .json, method: .DELETE, parameters: .none, headers: headers, id: id).send()
        
        NetworkManager().sendRequest(with: request) { (result:Result<DeleteCardResponse,NetworkError>) in
            switch result{
            
            case .success(_):
                //                self.showCards.remove(at: self.indexPath.row)
                
                self.getCard()
                print("刪除成功，第",self.btnTag,"張卡片")
                
            case .failure(let err):
                print("err.description = \(err.description)")
                print("err.errormessage = \(err.errMessage)")
                self.alertMessage(alertTitle: "發生錯誤", alertMessage: err.description, actionTitle: "稍後再試")
                self.loadingManager.startLoading429(vc: self)
            }
        }
    }
    func startLoading(){
        self.view.addSubview(glass)
        self.view.addSubview(loadIndicatorView)
        loadIndicatorView.startAnimating()
        glass.alpha = 0.1
        let animate = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn) {
            self.navigationController?.navigationBar.isHidden = true
            self.glass.alpha = 1
        }
        animate.startAnimation()
    }
    
    func stopLoading(){
        let animate = UIViewPropertyAnimator(duration: 2, curve: .easeIn) {
            self.glass.alpha = 0
        }
        animate.addCompletion { (position) in
            if position == .end {
                self.loadIndicatorView.removeFromSuperview()
                self.glass.removeFromSuperview()
            }
        }
        animate.startAnimation()
    }
    func startLoading429(){
        self.loadIndicatorView.removeFromSuperview()
        self.glass.removeFromSuperview()
        let worngText:UILabel = {
            let label = UILabel(frame: CGRect(
                                    x: 0, y: ScreenSize.centerY.value * 0.75, width: ScreenSize.width.value, height: 100))
            label.text = "系統存取中，稍後再試..."
            
            label.textColor = .red
            label.textAlignment = .center
            return label
        }()
        glass.alpha = 0
        self.view.addSubview(glass)
        self.view.addSubview(loadIndicatorView)
        self.view.addSubview(worngText)
        loadIndicatorView.startAnimating()
        let animate = UIViewPropertyAnimator(duration: 5, curve: .easeIn) {
            self.glass.alpha = 1
        }
        let endAnimate = UIViewPropertyAnimator(duration: 5, curve: .easeIn) {
            self.glass.alpha = 0.1
        }
        endAnimate.addCompletion { (position) in
            if position == .end {
                self.loadIndicatorView.removeFromSuperview()
                self.glass.removeFromSuperview()
                worngText.removeFromSuperview()
            }
        }
        animate.addCompletion { (position) in
            if position == .end {
                endAnimate.startAnimation()
            }
        }
        animate.startAnimation()
        
    }
}





extension MainPageVC: RefreshDelegate
{
    func refreshUserInfo()
    {
        loadingManager.startLoading(vc: self)
        if let userImage = UserDataManager.shared.userImage
        {
            self.headImage.image = userImage
            loadingManager.stopLoading()
        }
        getCard()
    }
    
    func refreshCardName()
    {
        getCard()
    }
    
    
}


