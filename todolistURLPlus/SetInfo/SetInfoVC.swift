//
//  SetInfoVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
class SetInfoVC:CanGetImageViewController,LoadAnimationAble{
    let setInfoView = SetInfoView()

    override func loadView() {
        super .loadView()
        self.view = setInfoView
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidAppear(_ animated: Bool) {
        setAction()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfoView.peopleView.image = UserDataManager.shared.userImage
        setInfoView.nameTextField.text = UserDataManager.shared.userData?.username
    }
    private func setAction(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(takeImage(reco:)))
            setInfoView.peopleView.addGestureRecognizer(tap)
    }
    
    @objc func takeImage(reco: UITapGestureRecognizer) {
        print(#function)
        let photoController = UIImagePickerController()
        photoController.delegate = self
        photoController.sourceType = .photoLibrary
        present(photoController, animated: true, completion: nil)
    }
    
//    func setUserData(userImage:UIImage?, userName: String?){
//        setInfoView.setUserData(
//            userImage: userImage ?? UIImage(systemName: "photo")!,
//            userName: userName ?? "Unknow")
//        self.view = setInfoView
//    }
    @objc func save(){
        func updataUserName(_ userName:String){
            SetInfoModelManerger.updateUserName(userName) { (result) in
                switch result{
                
                case .success(_):
                    self.stopLoading()
                    self.navigationController?.popViewController(animated: true)
                case .failure(let err ):
                    self.present(.makeAlert("Error", err.description, { () -> Void? in
                        self.stopLoading()
                    }), animated: true)
                }
            }
        }
        func errorType(){
           self.stopLoading()
            isEditing = false
            let ac = UIViewController.makeAlert("格式錯誤", "^([-_a-zA-Z0-9]{4,16})$"){}
            present(ac, animated: true, completion: nil)
        }
        func getUserName(){
            if let userName = setInfoView.nameTextField.text {
                if userName.isValidUserName {
                    updataUserName(userName)
                }else{
                    errorType()
                }
            }else{
                errorType()
            }
        }
        startLoading(self)
        if let image = setInfoView.peopleView.image {
            SetInfoModelManerger.updateUserImage(image) {
                print("updata Image")
                getUserName()
            }
        }else{
            print("not image")
            getUserName()
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
