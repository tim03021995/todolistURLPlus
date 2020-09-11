//
//  ListPageVC.swift
//  todolistURLPlus
//
//  Created by Jimmy on 2020/9/9.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class ListPageVC: UIViewController {
    let testData = ["a","b","c","d","e"]
    
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
            label.text = "How to get a Joey"
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.textColor = .white
            return label
    }()
    
    lazy var listBaseView: ListBaseView =
    {
        //test
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

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        listBaseView.tableView.delegate = self
        listBaseView.tableView.dataSource = self
        // Do any additional setup after loading the view.
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
        print("點此新增任務，但是還沒寫內部實作，我在\(#file)第\(#line)行等你唷～")
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
        return listBaseView.cellTitle.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
        cell.backgroundColor = .clear
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        cell.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
//        cell.cellTitleLabel.text = "\(listBaseView.cellTitle[indexPath.section])"
        cell.cellTitleLabel.text = testData[indexPath.section]
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print(indexPath)
            let vc = CardEditVC()
        #warning("我要card的id 感謝")
        vc.setTask(card: 0, task: indexPath.section)
        present(vc, animated: true, completion: nil)
        }

}