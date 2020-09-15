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
        if UserToken.shared.getToken() == "" {
            let vc = LoginVC.instantiate()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false , completion: nil)
        }
        else{
            let vc = MainPageVC()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil )
        }
    }
}
