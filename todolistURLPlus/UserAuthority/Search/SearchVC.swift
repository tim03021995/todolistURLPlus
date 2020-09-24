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
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.layer.cornerRadius = 15
        searchView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        searchView.layer.cornerRadius = 15
        searchView.layer.borderWidth = 3

    }

    @IBAction func dismissBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension SearchVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "Cell") as! UserAuthorityCell
        cell.updateSearchTBCell(name: "123", image: nil)
        return cell
    }
    
    
}
