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
        didSet {
            searchTableView.reloadData()
        }
    }

    var cardID: Int?

    @IBOutlet var searchView: UIView!

    @IBOutlet var searchBar: UISearchBar!

    @IBOutlet var searchTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
    }

    override func viewWillDisappear(_: Bool) {
        presentingViewController?.viewWillAppear(true)
    }

    // MARK: - Func

    convenience init(cardID: Int) {
        self.init(nibName: nil, bundle: nil)
        self.cardID = cardID
    }

    @IBAction func dismissBtn(_: UIButton) {
        dismiss(animated: true)
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

    private func searchUser(mail: String) {
        guard let token = UserToken.getToken() else { print("No Token"); return }
        let headers = ["userToken": token]

        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .GET, headers: headers, mail: mail).send()
        NetworkManager().sendRequest(with: request) {
            (res: Result<GetUserResponse, NetworkError>) in
            switch res {
            case let .success(data):
                self.users = [data.userData]
            case let .failure(err): print(err.description)
                self.present(.makeAlert("Error", err.errMessage) {}, animated: true)
            }
        }
    }

    private func addUser(mail: String) {
        guard let token = UserToken.getToken() else { print("No Token"); return }
        let headers = ["userToken": token]
        let parameters = ["email": mail]
        let request = HTTPRequest(endpoint: .groups, contentType: .json, method: .POST, parameters: parameters, headers: headers, id: cardID).send()
        print(request)
        NetworkManager().sendRequest(with: request) { (res: Result<PostGroupResponse, NetworkError>) in
            switch res {
            case .success:
                self.present(.makeAlert("Success", "新增成功") {
                    self.dismiss(animated: true)
                }, animated: true)
            case let .failure(err): print(err.description)
                print(err.errMessage)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView

extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return users.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "Cell") as! UserAuthorityCell
        cell.updateSearchTBCell(indexPath: indexPath, data: users)
        return cell
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let view = UIView()
        return view
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        100
    }

    func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        return UIView()
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        addUser(mail: users[indexPath.row].email)
    }
}

// MARK: - Serach

extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let userEmail = searchBar.text {
            if userEmail.isValidEMail {
                searchUser(mail: userEmail)
            } else {
                present(.makeAlert("Error", "請輸入正確Email") {
                    searchBar.becomeFirstResponder()
                }, animated: true)
            }
        }
    }
}
