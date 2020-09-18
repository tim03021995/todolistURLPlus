//
//  ListPageVC.swift
//  todolistURLPlus
//
//  Created by Jimmy on 2020/9/9.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class ListPageVC: UIViewController {
    
    var showCard: GetAllCardResponse.ShowCard!
//    lazy var showTasks = self.showCard.showTasks
    var showTasks:[GetAllCardResponse.ShowTask] = []
    {
        didSet
        {
            print("資料變更")
        }
    }
    var cardIndexPath = IndexPath()
    let backgroundImage:UIImageView = {
        return BackGroundFactory.makeImage(type: .background2)
    }()
    lazy var cardTitleLabel: UILabel =
        {
            let label = UILabel()
            label.frame = CGRect(x: ScreenSize.width.value * 0.05,
                                 y: self.bottomOfNaviBar * 1.25,
                                 width: ScreenSize.width.value * 0.9,
                                 height: ScreenSize.height.value * 0.1)
            
            
            label.text = self.showCard.cardName
            
            
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.textColor = .white
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
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        listBaseView.tableView.delegate = self
        listBaseView.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
     getTask()
//        reloadListTableView()
//        print("showTasks筆數 ＝ \(showTasks.count)")

    }
    
    func addSubview()
    {
        self.view.addSubview(backgroundImage)
        self.view.addSubview(cardTitleLabel)
        self.view.addSubview(listBaseView)
        self.view.addSubview(creatTaskBtn)
        
    }
    
    @objc func tapCreatTaskBtn()
    {
        toCardEditVC(data: showCard, indexPath: nil)
    }
    
    func toCardEditVC(data: GetAllCardResponse.ShowCard, indexPath: IndexPath?)
    {
        feedbackGenerator.impactOccurred()
        let vc = CardEditVC()
        if let indexPath = indexPath
       {
        let taskData = data.showTasks[indexPath.section]
        //        print("swction:\(indexPath.section) ,row:\(indexPath.row)")
        let editData = TaskModel(funtionType: .edit, cardID: taskData.cardID, taskID: taskData.id, title: taskData.title, description: taskData.description, image: nil, tag: nil)
        
        vc.setData(data: editData)
        navigationController?.pushViewController(vc, animated: true)

        }else
       {
        let cardID = showCard.id
        
        let createData = TaskModel(funtionType: .create, cardID: cardID)
             vc.setData(data: createData)
             navigationController?.pushViewController(vc, animated: true)
        }
    }
    func getTask(){
        let header = ["userToken":UserToken.shared.userToken]
        let request = HTTPRequest(endpoint: .card, contentType: .json, method: .GET, headers: header).send()
        NetworkManager().sendRequest(with: request) { (result:Result<GetAllCardResponse,NetworkError>) in
            switch result {
                
            case .success(let data):
                print("data.cardData?.showCards = \(data.userData.showCards.count)")
                let showTasks = data.userData.showCards[self.cardIndexPath.row].showTasks
                self.showTasks = showTasks
                print("showTasks筆數 = \(showTasks.count)")
                self.listBaseView.tableView.reloadData()
                print("Get成功")
                //這裡是成功解包的東西 直接拿data裡的東西 要解包
                // data.cardData........
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
        cell.cellTitleLabel.text = showTasks[indexPath.section].description ?? ""
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
            let vc = CardEditVC()
        let task = showTasks[indexPath.section]
        print("現在點擊的Task ID = \(task.id)")
        let taskModel = TaskModel(funtionType: .edit, cardID: task.cardID, taskID: task.id, title: task.title, description: task.description, image: nil, tag: ColorsButtonType(rawValue: task.tag!) )
        vc.setData(data: taskModel)

        navigationController?.pushViewController(vc, animated: true)

        }

}
