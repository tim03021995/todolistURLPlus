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
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()


}
    func setTaskData(data:TaskData){
        cardEditView.setUserData(
        image: data.image ?? UIImage(systemName: "photo")!,
        title: data.title,
        script: data.script ?? "Unknow")
        self.cardEditView.colorsCollectionView.dataSource = self
        self.cardEditView.colorsCollectionView.delegate = self
        self.view = cardEditView
    }
    
}
extension CardEditVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
