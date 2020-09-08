//
//  CardEditVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/7.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class CardEditVC: UIViewController {
    private let cardEditView = CardEditView()
    override func loadView() {
        super.loadView()
        cardEditView.colorsCollectionView.delegate = self
        cardEditView.colorsCollectionView.dataSource = self
        self.view = cardEditView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
}
    func setTaskData(data:TaskData){
        cardEditView.setUserData(
        image: data.image ?? UIImage(systemName: "photo")!,
        title: data.title,
        script: data.script ?? "Unknow")
        self.view = cardEditView
    }
    
}

