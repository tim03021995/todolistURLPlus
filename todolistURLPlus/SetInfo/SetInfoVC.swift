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
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        let image = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        
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
        if let image = setInfoView.peopleView.image {
            SetInfoModelManerger.updateUserImage(image) {
            print("updata Image")
            }
        }else{
            print("not image")
        }
        if let userName = setInfoView.nameTextField.text {
            SetInfoModelManerger.updateUserName(userName) {
                print("updata name")
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            print("not name")
        }
    }

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
