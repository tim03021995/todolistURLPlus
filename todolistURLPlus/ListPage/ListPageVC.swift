//
//  ListPageVC.swift
//  todolistURLPlus
//
//  Created by Jimmy on 2020/9/9.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit



class ListPageVC: UIViewController {
    weak var delegate: RefreshDelegate!
    var showCard: GetCardResponse.ShowCard!
    
    var showTasks:[GetCardResponse.ShowTask] = []
    var cardIndexPath = IndexPath()
    var collectionStyle: WhichCollectionView!
    let backgroundImage:UIImageView = {
        return BackGroundFactory.makeImage(type: .background2)
    }()
    lazy var cardTitleTextField: CustomLogINTF =
        {
            let label = CustomLogINTF()
            label.frame = CGRect(x: ScreenSize.width.value * 0.05,
                                 y: self.bottomOfNaviBar * 1.25,
                                 width: ScreenSize.width.value * 0.9,
                                 height: ScreenSize.height.value * 0.05)
            
            
            label.text = self.showCard.cardName
            
            
            label.adjustsFontSizeToFitWidth = true
            
            label.textAlignment = .center
            
            label.font = UIFont.boldSystemFont(ofSize: 30)
//            label.textColor = .white
            return label
    }()
    
    lazy var listBaseView: ListBaseView =
        {
            let view = ListBaseView()
            view.frame = CGRect(x: 0, y: 0, width: ScreenSize.width.value, height: ScreenSize.height.value)
            return view
    }()
    lazy var bottomOfNaviBar = navigationController?.navigationBar.frame.maxY ?? 0
    lazy var creatTaskBtn: UIButton =
        {
            let y = (ScreenSize.height.value - self.listBaseView.frame.maxY) * 0.1 +  self.listBaseView.frame.maxY
            let height = (ScreenSize.height.value - self.listBaseView.frame.maxY) * 0.8
            let btn = UIButton()
            btn.frame = CGRect(x: ScreenSize.width.value * 0.25, y: ScreenSize.height.value * 0.85, width: ScreenSize.width.value * 0.5, height: ScreenSize.height.value * 0.08)
            btn.setTitle("Add a new task", for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.contentHorizontalAlignment = .center
            btn.contentVerticalAlignment = .center
            btn.titleLabel?.adjustsFontSizeToFitWidth = true
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
            btn.addTarget(self, action: #selector(self.tapCreatTaskBtn), for: .touchDown)
            
            return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        listBaseView.tableView.delegate = self
        listBaseView.tableView.dataSource = self
        cardTitleTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        creatTaskBtn.isEnabled = true
    }
    override func viewDidAppear(_ animated: Bool) {
        getTask()
        print("卡片ID是 = ",showCard.id)
        
    }
  
    func addSubview()
    {
        self.view.addSubview(backgroundImage)
        self.view.addSubview(listBaseView)
        self.view.addSubview(cardTitleTextField)
        self.view.addSubview(creatTaskBtn)
        
    }
    
    @objc func tapCreatTaskBtn()
    {
        creatTaskBtn.isEnabled = false
        toCardEditVC(data: showCard, indexPath: nil)
    }
    @objc func tapToUserAuthority(){
        let vc = UserAuthorityVC(id: showCard.id)
        present(vc, animated: true, completion: nil)
        
    }
    func toCardEditVC(data: GetCardResponse.ShowCard, indexPath: IndexPath?)
    {
        feedbackGenerator.impactOccurred()
        let vc = CardEditVC()
        if let indexPath = indexPath
        {
            let taskData = data.showTasks[indexPath.section]
            
            vc.editPage(cardID: taskData.cardID, taskID: taskData.id, title: taskData.title, description: taskData.description, image: nil, tag: nil)
            navigationController?.pushViewController(vc, animated: true)
            
        }else
        {
            let cardID = showCard.id
            vc.createPage(cardID: cardID)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func classifiedSingleAndMutiple(showCards:[GetCardResponse.ShowCard])
    {
        showCards.map { card in
            if card.id == self.showCard.id
            {
                showTasks = card.showTasks
            }
        }
    }
    
    func getTask(){
        let header = ["userToken":UserToken.shared.userToken]
        let request = HTTPRequest(endpoint: .card, contentType: .json, method: .GET, headers: header).send()
        NetworkManager.sendRequest(with: request) { (result:Result<GetCardResponse,NetworkError>) in
            switch result {
                
            case .success(let data):
//                let showTasks = data.userData.showCards[self.cardIndexPath.row].showTasks
//
//                self.showTasks = showTasks
                let showCards = data.userData.showCards
                self.classifiedSingleAndMutiple(showCards: showCards)
                self.listBaseView.tableView.reloadData()
                
            case .failure(let err):
                print("Get失敗\(err.description)")
            }
        }
    }
    private func reloadListTableView(){
        let reloadView = self.listBaseView
        reloadView.tableView.delegate = self
        reloadView.tableView.dataSource = self
        reloadView.reloadTableView()
        //           self.listBaseView = reloadView
    }
    
}


extension ListPageVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = listBaseView.fullScreenMaxY * 0.015
        return cellSpacingHeight
    }
}

extension ListPageVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let taskCount = showTasks.count
        showCard.showTasks.count
        return taskCount
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
        cell.cellTitleLabel.text = showTasks[indexPath.section].title 
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = CardEditVC()
        let task = showTasks[indexPath.section]
        
        //        let taskModel = TaskModel(funtionType: .edit, cardID: task.cardID, taskID: task.id, title: task.title, description: task.description, image: nil, tag: ColorsButtonType(rawValue: task.tag!) )
        // vc.setData(data: taskModel)
        vc.editPage(cardID: task.cardID, taskID: task.id, title: task.title, description: task.description, image: task.image, tag: ColorsButtonType(rawValue: task.tag!))
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func putCardName(){
        let header = ["userToken":UserToken.shared.userToken]
        let parameters: [String: Any] = ["card_name": cardTitleTextField.text ?? ""]
        let request = HTTPRequest(endpoint: .card, contentType: .json, method: .PUT, parameters: parameters, headers: header, id: showCard.id).send()
        NetworkManager.sendRequest(with: request) { (result:Result<PutCardResponse,NetworkError>) in
            switch result {
                
            case .success( _):
               print("卡片名稱更新成功")
               self.delegate.refreshCardName()
                
            case .failure(let err):
                print(err.description)
                self.delegate.refreshCardName()

            }
        }
    }
    
    
}
extension ListPageVC: UITextFieldDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        putCardName()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        putCardName()
        return true
    }
}

