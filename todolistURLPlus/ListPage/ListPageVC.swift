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
    lazy var showTasks = self.showCard.showTasks
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
        print("cardID = \(cardID)")
        let createData = TaskModel(funtionType: .create, cardID: cardID)
             vc.setData(data: createData)
             navigationController?.pushViewController(vc, animated: true)
        }
    }
    func getTask(){
        let header = ["userToken":UserToken.shared.userToken]
        let request = HTTPRequest(endpoint: .task, contentType: .json, method: .GET, headers: header).send()
        NetworkManager().sendRequest(with: request) { (result:Result<GetAllCardResponse,NetworkError>) in
            switch result {
                
            case .success(let data):
                print("data.cardData?.showCards = \(data.cardData.showCards.count)")
                let showTasks = data.cardData.showCards[self.cardIndexPath.row].showTasks
                self.showTasks = showTasks
                self.listBaseView.tableView.reloadData()
                print(data)//這裡是成功解包的東西 直接拿data裡的東西 要解包
                // data.cardData........
            case .failure(let err):
                print("Get失敗\(err.description)")
            }
        }
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
        let taskCount = showCard.showTasks.count
        return taskCount
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
        cell.cellTitleLabel.text = showTasks[indexPath.section].description ?? ""
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //     print(indexPath)
        print("swction:\(indexPath.section) ,row:\(indexPath.row)")
            let vc = CardEditVC()
        #warning("我要card的id 感謝")
        let taskModel = TaskModel(funtionType: .edit, cardID: 1, taskID: 1, title: "123", description: "123", image: nil, tag: .darkBlue)
        vc.setData(data: taskModel)
        //TEST
  
//        show(vc, sender: nil)
        navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true, completion: nil)
        }

}
