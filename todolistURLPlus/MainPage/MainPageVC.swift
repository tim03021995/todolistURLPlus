//
//  MainPageVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
import SnapKit

class MainPageVC: UIViewController {
    ///設置背景
    let userName = ""
    let backgroundImage:UIImageView = {
        return BackGroundFactory.makeImage(type: .background2)
    }()
    ///設置頭貼
    lazy var headImage: UIImageView =
    {
        let head = UserImageFactory.makeImageView(size: .small, image: nil)
        head.backgroundColor = .gray
        let nvBottom = navigationController?.navigationBar.frame.maxY
        let space = 15
        head.center = CGPoint(
            x: space + Int(head.frame.width * 0.5),
            y: Int(nvBottom!) + space + Int(head.frame.width * 0.3)
        )
        return head
    }()
    
    lazy var welcomeLabel: UILabel =
    {
       let label = UILabel()
        label.frame = CGRect(x: ScreenSize.width.value * 0.05,
                             y: self.headImage.frame.maxY * 1.05,
                             width: ScreenSize.width.value * 0.9,
                             height: self.headImage.frame.height  * 0.8)
        label.text = "Welcome back \(self.userName)"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(backgroundImage)
        self.view.addSubview(headImage)
        self.view.addSubview(welcomeLabel)
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    }

