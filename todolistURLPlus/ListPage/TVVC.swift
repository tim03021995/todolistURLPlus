//
//  ViewController.swift
//  tableViewCell
//
//  Created by 陳冠諭 on 2020/9/10.
//  Copyright © 2020 KuanYu. All rights reserved.
//


import UIKit

class TVVC: UIViewController {
    
    var cellTitle = ["title", "title", "title", "title", "title"]
    var tableView = UITableView()
    var baseView = UIView()
    var fullScreenMaxY = UIScreen.main.bounds.maxY
    
    
    func setTableView(){
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = fullScreenMaxY * 0.105
        tableView.register(TVVCCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    func setBaseView(){
        baseView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        baseView.layer.borderColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        baseView.layer.cornerRadius = 15
        baseView.layer.borderWidth = 3
        self.view.addSubview(baseView)
    }
    
    func setTableViewConstriants(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor,constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo:baseView.trailingAnchor, constant: -20 ).isActive = true

            }
    
    func setBaseViewConstriants(){
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        baseView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        baseView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.67).isActive = true
        baseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        baseView.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -10 ).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseView()
        setTableView()
        setTableViewConstriants()
        setBaseViewConstriants()
    }
}

extension TVVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = fullScreenMaxY * 0.015
        return cellSpacingHeight
    }
}

extension TVVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.cellTitle.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TVVCCell
        cell.backgroundColor = .clear
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        cell.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
//        cell.selectedBackgroundView = cell.backGroundView
        cell.cellTitleLabel.text = "\(cellTitle[indexPath.section])"
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print(indexPath)
        }

}
