//
//  ListPageVC.swift
//  todolistURLPlus
//
//  Created by Jimmy on 2020/9/9.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class ListPageVC: UIViewController, LoadAnimationAble {
    weak var delegate: RefreshDelegate!
    var showCard: GetCardResponse.ShowCard!
    var showTasks: [GetCardResponse.ShowTask] = []
    let backgroundImage: UIImageView = {
        BackGroundFactory.makeImage(type: .background2)
    }()
    
    lazy var cardTitleTextField: CustomLogINTF = {
        let label = CustomLogINTF()
        label.frame = CGRect(x: ScreenSize.width.value * 0.05,
                             y: self.bottomOfNaviBar * 1.25,
                             width: ScreenSize.width.value * 0.9,
                             height: ScreenSize.height.value * 0.05)
        label.text = self.showCard.cardName
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    lazy var listBaseView: ListBaseView = {
        let view = ListBaseView()
        view.frame = CGRect(x: 0, y: 0, width: ScreenSize.width.value, height: ScreenSize.height.value)
        return view
    }()
    
    lazy var bottomOfNaviBar = navigationController?.navigationBar.frame.maxY ?? 0
    lazy var creatTaskBtn: UIButton = {
        let btn = CustomButton()
        let y = (ScreenSize.height.value - self.listBaseView.frame.maxY) * 0.1 + self.listBaseView.frame.maxY
        let height = (ScreenSize.height.value - self.listBaseView.frame.maxY) * 0.8
        
        btn.frame = CGRect(x: ScreenSize.width.value * 0.25, y: ScreenSize.height.value * 0.85, width: ScreenSize.width.value * 0.5, height: ScreenSize.height.value * 0.06)
        btn.setTitle("Add a new task", for: .normal)
        btn.backgroundColor = .mainColorGlass
        btn.setTitleColor(.white, for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.contentVerticalAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.layer.cornerRadius = btn.frame.height * 0.25
        btn.addTarget(self, action: #selector(self.tapCreatTaskBtn), for: .touchDown)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        listBaseView.tableView.delegate = self
        listBaseView.tableView.dataSource = self
        cardTitleTextField.delegate = self
    }
    
    override func viewWillAppear(_: Bool) {
        navigationController?.navigationBar.isHidden = true
        creatTaskBtn.isEnabled = true
    }
    
    override func viewDidAppear(_: Bool) {
        getTask()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        putCardName()
    }
    
    func addSubview() {
        view.addSubview(backgroundImage)
        view.addSubview(listBaseView)
        view.addSubview(cardTitleTextField)
        view.addSubview(creatTaskBtn)
    }
    
    @objc func tapCreatTaskBtn() {
        creatTaskBtn.isEnabled = false
        feedbackGenerator.impactOccurred()
        toCardEditVC(data: showCard, indexPath: nil)
    }
    
    @objc func tapToUserAuthority() {
        let vc = UserAuthorityVC(id: showCard.id)
        feedbackGenerator.impactOccurred()
        present(vc, animated: true, completion: nil)
    }
    
    func toCardEditVC(data: GetCardResponse.ShowCard, indexPath: IndexPath?) {
        let vc = CardEditVC()
        if let indexPath = indexPath {
            let taskData = data.showTasks[indexPath.section]
            
            vc.editPage(cardID: taskData.cardID, taskID: taskData.id, title: taskData.title, description: taskData.description, image: nil, tag: nil)
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            let cardID = showCard.id
            vc.createPage(cardID: cardID)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func classifiedSingleAndMutiple(showCards: [GetCardResponse.ShowCard]) {
        showCards.forEach { card in
            if card.id == self.showCard.id {
                showTasks = card.showTasks
            }
        }
    }
    
    // MARK: getTask
    
    func getTask() {
        startLoading(self)
        guard let token = UserToken.getToken() else { print("No Token"); return }
        let headers = ["userToken": token]
        let request = HTTPRequest(endpoint: .card, contentType: .json, method: .GET, headers: headers).send()
        NetworkManager().sendRequest(with: request) { (result: Result<GetCardResponse, NetworkError>) in
            switch result {
            case let .success(data):
                let showCards = data.userData.showCards
                self.classifiedSingleAndMutiple(showCards: showCards)
                self.listBaseView.tableView.reloadData()
                self.stopLoading()
            case let .failure(err):
                self.alertMessage(alertTitle: "發生錯誤", alertMessage: err.description, actionTitle: "稍後再試")
            }
        }
    }
    
    private func reloadListTableView() {
        let reloadView = listBaseView
        reloadView.tableView.delegate = self
        reloadView.tableView.dataSource = self
        reloadView.reloadTableView()
    }
}

extension ListPageVC: UITableViewDelegate {
    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = listBaseView.fullScreenMaxY * 0.015
        return cellSpacingHeight
    }
}

extension ListPageVC: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in _: UITableView) -> Int {
        let taskCount = showTasks.count
        return taskCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
        cell.setUpCell(showTasks: showTasks, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CardEditVC()
        let task = showTasks[indexPath.section]
        vc.editPage(cardID: task.cardID, taskID: task.id, title: task.title, description: task.description, image: task.image, tag: ColorsButtonType(rawValue: task.tag!))
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func putCardName() {
        guard let token = UserToken.getToken() else { print("No Token"); return }
        let headers = ["userToken": token]
        let parameters: [String: Any] = ["card_name": cardTitleTextField.text == "" ? "新增的卡片" : cardTitleTextField.text! ]
        let request = HTTPRequest(endpoint: .card, contentType: .json, method: .PUT, parameters: parameters, headers: headers, id: showCard.id).send()
        NetworkManager().sendRequest(with: request) { (result: Result<PutCardResponse, NetworkError>) in
            switch result {
            case .success:
                print("卡片名稱更新成功")
                self.delegate.refreshCardName()
                
            case let .failure(err):
                print(err.description)
                self.delegate.refreshCardName()
                self.alertMessage(alertTitle: "發生錯誤", alertMessage: err.errMessage, actionTitle: "稍後再試")
            }
        }
    }
}

extension ListPageVC: UITextFieldDelegate {
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_: UITextField) -> Bool {
        view.endEditing(true)
        putCardName()
        return true
    }
}
