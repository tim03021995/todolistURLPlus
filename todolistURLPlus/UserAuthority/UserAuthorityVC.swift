//
//  UserAuthority.swift
//  todolistURLPlus
//
//  Created by 陳冠諭 on 2020/9/14.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class UserAuthorityVC: UIViewController {
    //MARK:- Properties
    
    var users : [GetGroupResponse.UserData] = []{
        didSet{
            myTableView.reloadData()
        }
    }
    var myTableView = UITableView()
    var baseView = UIView()
    var memberLabel = UILabel()
    var fullScreenMaxY = UIScreen.main.bounds.maxY
    var fullScreen = UIScreen.main.bounds.size
    var cardID: Int?
    
    
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let id = cardID else{
            print("no cardID")
            return
        }
        getAllUsers(cardID: id)
    }

    
    //MARK:- Func
    
    convenience init(id:Int){
        self.init(nibName: nil, bundle: nil)
        self.cardID = id
    }
    
    ///GET 這張卡片有哪些使用者
    private func getAllUsers(cardID:Int){
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        let headers = ["userToken":token]
        let request = HTTPRequest(endpoint: .groupsCard, contentType: .json, method: .GET, headers: headers, id: cardID).send()
        NetworkManager().sendRequest(with: request) { (result:Result<GetGroupResponse,NetworkError>) in
            switch result {
            case .success(let data): self.users = data.usersData
            case .failure(let err):  print(err.description)
            self.present(.makeAlert("Error", err.errMessage, {
                self.dismiss(animated: true, completion: nil)
            }), animated: true)
            }
        }
    }
    ///DELETE 刪除使用者
    private func deleteUser(indexPath:IndexPath){
        guard users[0].id != users[indexPath.row].id else{
            present(.makeAlert("Error", "Can't Delete Card Owner", {}), animated: true)
            return
        }
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        let headers = ["userToken":token]
        let parameters = ["user_id":users[indexPath.row].id]
        let request = HTTPRequest(endpoint: .groups, contentType: .json, method: .DELETE, parameters: parameters, headers: headers, id: cardID).send()
        NetworkManager().sendRequest(with: request) { (res:Result<DeleteGroupResponse,NetworkError>) in
            switch res {
            case .success(let a): print(a.status)
                self.myTableView.beginUpdates()
                self.users.remove(at: indexPath.row)
                self.myTableView.deleteRows(at: [indexPath], with: .fade)
                self.myTableView.endUpdates()
                print("Delete Success")
            case .failure(let err): print(err.description)
            self.present(.makeAlert("Error", err.errMessage, {}), animated: true)
            }
        }
    }
    
    
    //進入搜尋模式
    @objc func inviteSomeone(){
        myTableView.isEditing = false

        let vc = SearchVC(cardID: cardID!)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
    
    //切換編輯模式
    @objc func removeSomeone(){
        myTableView.setEditing(!myTableView.isEditing, animated: true)
    }
    
    //MARK:- UISetting
    
    fileprivate func setView() {
        view.addSubview(backgroundImage)
        setBaseView()
        setTableView()
        setMemberLabel()
        setMemberLabelConstriants()
        setInviteBtnViewConstraints()
        setRemoveBtnViewConstrants()
        setInviteBtnConstraints()
        setRemoveBtnConstrants()
        setTableViewConstriants()
        setBaseViewConstriants()
    }
    
    private func setMemberLabel(){
        memberLabel.frame = CGRect()
        memberLabel.text = "Members"
        memberLabel.adjustsFontSizeToFitWidth = true
        memberLabel.textAlignment = .center
        memberLabel.font = UIFont.boldSystemFont(ofSize: 30)
        memberLabel.textColor = .white
        self.view.addSubview(memberLabel)
    }
    
    private func setTableView(){
        
        myTableView.backgroundColor = .clear
        myTableView.separatorStyle = .none
        myTableView.rowHeight = fullScreenMaxY * 0.13
        myTableView.register(UserAuthorityCell.self, forCellReuseIdentifier: "Cell")
        myTableView.delegate = self
        myTableView.dataSource = self
        self.view.addSubview(myTableView)
    }
    
    private func setTestCube(){
        testCube.translatesAutoresizingMaskIntoConstraints = false
        testCube.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        testCube.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant:0).isActive = true
        testCube.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        testCube.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        testCube.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10 ).isActive = true
    }
    
    private func setTestCube1(){
        testCube.translatesAutoresizingMaskIntoConstraints = false
        testCube.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        testCube.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant:-50).isActive = true
        testCube.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        testCube.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        testCube.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10 ).isActive = true
    }
    
    private func setBaseView(){
        baseView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        baseView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        baseView.layer.cornerRadius = 15
        baseView.layer.borderWidth = 3
        self.view.addSubview(baseView)
    }
    
    private func setMemberLabelConstriants(){
        memberLabel.translatesAutoresizingMaskIntoConstraints = false
        memberLabel.topAnchor.constraint(equalTo:view.topAnchor,constant: 10 ).isActive = true

        memberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        memberLabel.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.3).isActive = true
        memberLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setTableViewConstriants(){
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 10).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor,constant: -10).isActive = true
        myTableView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 20).isActive = true
        myTableView.trailingAnchor.constraint(equalTo:baseView.trailingAnchor, constant: -20 ).isActive = true
    }
    
    private func setBaseViewConstriants(){
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        baseView.topAnchor.constraint(equalTo: inviteBtnView.bottomAnchor,constant: 10).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -30).isActive = true
//        baseView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6).isActive = true
        baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10 ).isActive = true
    }
    
    private func setInviteBtnViewConstraints(){
        inviteBtnView.translatesAutoresizingMaskIntoConstraints = false
        
        inviteBtnView.leadingAnchor.constraint(equalTo: removeBtnView.trailingAnchor,constant: 20).isActive = true
        inviteBtnView.topAnchor.constraint(equalTo: removeBtnView.topAnchor,constant: 0).isActive = true
        inviteBtnView.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier:0.2).isActive = true
        inviteBtnView.heightAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.2).isActive = true
    }
    
    private func setRemoveBtnViewConstrants(){
        removeBtnView.translatesAutoresizingMaskIntoConstraints = false
        removeBtnView.leadingAnchor.constraint(equalTo:view.leadingAnchor ,constant: 20).isActive = true
        removeBtnView.topAnchor.constraint(equalTo: memberLabel.bottomAnchor,constant: 10).isActive = true
        removeBtnView.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier:0.2).isActive = true
        removeBtnView.heightAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.2).isActive = true
    }
    
    private func setInviteBtnConstraints(){
        inviteBtn.translatesAutoresizingMaskIntoConstraints = false
        inviteBtn.topAnchor.constraint(equalTo: inviteBtnView.topAnchor,constant:5).isActive = true
        inviteBtn.leadingAnchor.constraint(equalTo: inviteBtnView.leadingAnchor,constant: 5).isActive = true
        inviteBtn.trailingAnchor.constraint(equalTo: inviteBtnView.trailingAnchor,constant: -5).isActive = true
        inviteBtn.heightAnchor.constraint(equalTo: inviteBtnView.heightAnchor,multiplier: 0.75).isActive = true
        
    }
    
    private func setRemoveBtnConstrants(){
        removeBtn.translatesAutoresizingMaskIntoConstraints = false
        removeBtn.topAnchor.constraint(equalTo: removeBtnView.topAnchor,constant:5).isActive = true
        removeBtn.leadingAnchor.constraint(equalTo: removeBtnView.leadingAnchor,constant: 5).isActive = true
        removeBtn.trailingAnchor.constraint(equalTo: removeBtnView.trailingAnchor,constant: -5).isActive = true
        removeBtn.heightAnchor.constraint(equalTo: removeBtnView.heightAnchor,multiplier: 0.75).isActive = true
    }
    
    
    //MARK:- UI
    
    
    let backgroundImage:UIImageView = {
        return BackGroundFactory.makeImage(type: .background2)
    }()
    
    //invite buttom
    lazy var inviteBtnView: UIView = {
        let inviteBtnView = UIView()
        inviteBtnView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        inviteBtnView.layer.cornerRadius = 10
        self.view.addSubview(inviteBtnView)
        return inviteBtnView
    }()
    lazy var inviteBtn: UIButton = {
        let inviteBtn = UIButton()
//        inviteBtn.backgroundColor = .clear
        inviteBtn.setBackgroundImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        inviteBtn.addTarget(self, action: #selector(inviteSomeone), for: .touchUpInside)
        inviteBtn.setTitle("Invite", for: .normal)
        inviteBtn.tintColor = .black
        inviteBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        inviteBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        inviteBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        inviteBtn.setTitleColor(.black, for: .normal)
        inviteBtn.frame = CGRect(x: 20, y: 20, width:fullScreen.width * 0.5 , height: fullScreen.width * 0.25)
        inviteBtn.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                 left: 0,
                                                 bottom: -inviteBtn.frame.height * 0.75,
                                                 right: 0)
        
        self.view.addSubview(inviteBtn)
        return inviteBtn
    }()
    
    lazy var removeBtn: UIButton = {
        let removeBtn = UIButton()
//        removeBtn.backgroundColor = .clear
        removeBtn.setBackgroundImage(UIImage(systemName: "person.badge.minus"), for: .normal)
        removeBtn.addTarget(self, action: #selector(removeSomeone), for: .touchUpInside)
        removeBtn.setTitle("Remove", for: .normal)
        removeBtn.tintColor = .black
        removeBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        removeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        removeBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        removeBtn.setTitleColor(.black, for: .normal)
        removeBtn.frame = CGRect(x: 20, y: 20, width:fullScreen.width * 0.5 , height: fullScreen.width * 0.25)
        removeBtn.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                 left: 0,
                                                 bottom: -removeBtn.frame.height * 0.75,
                                                 right: 0)
        
        self.view.addSubview(removeBtn)
        return removeBtn
    }()
    
    //remove buttom view
    lazy var removeBtnView: UIView =
        {
            let removeBtnView = UIView()
            removeBtnView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
            removeBtnView.layer.cornerRadius = 10
            self.view.addSubview(removeBtnView)
            return removeBtnView
    }()
    
    lazy var testCube:UIView = {
        var testCube = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testCube.backgroundColor = .black
        self.view.addSubview(testCube)
        return testCube
    }()
    
    
}
//MARK:- UITableViewDelegate

extension UserAuthorityVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = fullScreenMaxY * 0.015 //0.015
        return cellSpacingHeight
    }
    
}

//MARK:- UITableViewDataSource
extension UserAuthorityVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserAuthorityCell
        cell.updateCell(indexPath:indexPath, data: users)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteUser(indexPath: indexPath)
        }
    }
    
}



