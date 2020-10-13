//
//  SearchVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/23.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    var users: [GetUserResponse.UserData] = [] {
        didSet{
            searchTableView.reloadData()
        }
    }
    var cardID:Int?
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
    }
    override func viewWillDisappear(_ animated: Bool) {
        presentingViewController?.viewWillAppear(true)
    }
    //MARK:- Func
    
    convenience init(cardID:Int){
        self.init(nibName:nil, bundle: nil)
        self.cardID = cardID
    }
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    fileprivate func setting() {
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        searchTableView.register(UserAuthorityCell.self, forCellReuseIdentifier: "Cell")
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.backgroundColor = .white
        searchTableView.layer.cornerRadius = 15
        searchView.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        searchView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        searchView.layer.cornerRadius = 15
        searchView.layer.borderWidth = 3
        searchBar.placeholder = "請輸入使用者email"
    }
    
    private func searchUser(mail:String){
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        let headers = ["userToken":token]
        
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .GET, headers: headers, mail: mail).send()
        NetworkManager(self).sendRequest(with: request) {
            (res:Result<GetUserResponse,NetworkError>) in
            switch res {
                
            case .success(let data ):
                self.users = [data.userData]
            case .failure(let err): print(err.description)
            self.present(.makeAlert("Error", err.errMessage, {
            }), animated: true)
            }
        }
    }
    
    private func addUser(mail:String){
        guard let token = UserToken.getToken() else{ print("No Token"); return }
        let headers = ["userToken":token]
        let parameters = ["email":mail]
        let request = HTTPRequest(endpoint: .groups, contentType: .json, method: .POST, parameters: parameters, headers: headers, id: cardID).send()
        print(request)
        NetworkManager().sendRequest(with: request) { (res:Result<PostGroupResponse,NetworkError>) in
            switch res{
            case .success(_):
                self.present(.makeAlert("Success", "新增成功", {
                    self.dismiss(animated: true)
                }), animated: true)
            case .failure(let err): print(err.description)
            print(err.errMessage)
            }
        }
    }
    
}

//MARK:- TableView

extension SearchVC:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "Cell") as! UserAuthorityCell
        cell.updateSearchTBCell(indexPath: indexPath, data: users)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addUser(mail: users[indexPath.row].email)
    }
}

//MARK:- Serach
extension SearchVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let userEmail = searchBar.text{
            if userEmail.isValidEMail{
                searchUser(mail: userEmail)
            }else{
                self.present(.makeAlert("Error", "請輸入正確Email", {
                    searchBar.becomeFirstResponder()
                }), animated: true)
            }
        }
    }
}
