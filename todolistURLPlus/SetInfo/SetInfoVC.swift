//
//  SetInfoVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
class SetInfoVC:UIViewController{
    let setInfoView = SetInfoView()
    
    override func loadView() {
        super .loadView()
        self.view = setInfoView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        autoPushView()
    }
    @objc func takeImage() {
        let photoController = UIImagePickerController()
        photoController.delegate = self
        photoController.sourceType = .photoLibrary
        present(photoController, animated: true, completion: nil)
    }
    func setUserData(userImage:UIImage?, userName: String?){
        setInfoView.setUserData(
            userImage: userImage ?? UIImage(systemName: "photo")!,
            userName: userName ?? "Unknow")
        self.view = setInfoView
    }
    @objc func save(){
        print("updata")
        self.dismiss(animated: true, completion: nil)        
    }
//    func getViewData()->SetInfoModel{
//        var data = SetInfoModel(
//            UserName: self.setInfoView.nameTextField.text ?? "Unknow",
//            UserImage: self.setInfoView.peopleView.image ?? UIImage(systemName: "photo")!)
//    }

}
extension SetInfoVC:UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            setInfoView.setPhoto(userImage: image)
        }

        self.view = setInfoView
        dismiss(animated: true, completion: nil)
    }
}
