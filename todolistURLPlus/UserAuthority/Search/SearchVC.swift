//
//  SearchVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/23.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.register(UserAuthorityCell.self, forCellReuseIdentifier: "Cell")

    }

}

extension SearchVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "Cell") as! UserAuthorityCell
        cell.textLabel?.text = "123"
        return cell
    }
    
    
}
