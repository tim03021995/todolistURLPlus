//
//  CardEditVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/7.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class CardEditVC: UIViewController {
    
    override func loadView() {
        super.loadView()
        let view = CardEditView()
        view.colorsCollectionView.delegate = self
        view.colorsCollectionView.dataSource = self
        view.setUserData(
            image: UIImage(named: "joey") ,
            title: "Title",
            script: "Learning English use a limited vocabulary and are read at a slower pace than VOA's other English broadcasts. Previously known as Special English.")
        self.view = view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
}
