//
//  SearchMemberVC.swift
//  todolistURLPlus
//
//  Created by 陳冠諭 on 2020/9/15.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class SearchMemberVC: UIViewController {

    
    //MARK:- Properties
    
    
    var mySearchBar = UISearchBar()
    var baseView = UIView()
    var searchTableView = UITableView()
    


    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.titleView = mySearchBar
        setSearchBar()
        setTableView()
    }
    //MARK:- Func
    fileprivate func setSearchBar(){
        mySearchBar.delegate = self
        mySearchBar.becomeFirstResponder()
        mySearchBar.placeholder = "Search"
    }
    fileprivate func setTableView(){
        searchTableView.backgroundColor = .clear
        searchTableView.separatorStyle = .none
        searchTableView.rowHeight = 100
        searchTableView.register(UserAuthorityCell.self, forCellReuseIdentifier: "Cell")
        searchTableView.delegate = self
        searchTableView.dataSource = self
        self.view.addSubview(searchTableView)
        setTableViewConstriants()
    }
    private func setTableViewConstriants(){
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -20).isActive = true
        searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchTableView.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: 0 ).isActive = true
    }

}

extension SearchMemberVC:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension SearchMemberVC : UITableViewDelegate , UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "Cell") as! UserAuthorityCell
//        cell.updateSearchTBCell(name: "123", image: nil)
         return cell
    }
}

