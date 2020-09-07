//
//  SetInfoVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
class SetInfoVC:UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    var userImage:UIImage?
    var userName:String?
    override func loadView() {
        super .loadView()
        let setInfoView = SetInfoView()
        setInfoView.setUserData(userImage: userImage, userName: userName)
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.originalImage] as? UIImage
        userImage = image
        let setInfoView = SetInfoView()
        setInfoView.setUserData(userImage: userImage, userName: userName)
        self.view = setInfoView
    dismiss(animated: true, completion: nil)
    }
}

