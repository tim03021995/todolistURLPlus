//
//  MainVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/15.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class MainVC: UIViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserToken.shared.userToken == "" {
            let vc = LoginVC.instantiate()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false , completion: nil)
        }
        else{
            let vc = MainPageVC()
            let nc = UINavigationController(rootViewController: vc)
            
//            vc.modalPresentationStyle = .fullScreen
//            nc.modalPresentationStyle = .fullScreen
            nc.modalTransitionStyle = .crossDissolve
            vc.modalTransitionStyle = .crossDissolve
            present(nc, animated: false, completion: nil )
        }
    }
}
