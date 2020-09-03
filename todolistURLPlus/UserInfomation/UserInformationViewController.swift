//
//  UserInformationViewController.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/2.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class UserInformationViewController: UIViewController {
    override func loadView() {
        super .loadView()
        let userInformationView = UserInfomationView()
        self.view = userInformationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @objc func information (){
 
    }
    @objc func modifyPassword
(){

    }
}
