//
//  SetInfoVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
class SetInfoVC: CanGetImageViewController, LoadAnimationAble {
    let setInfoView = SetInfoView()

    override func loadView() {
        super.loadView()
        view = setInfoView
    }

    override func viewWillAppear(_: Bool) {
//        navigationController?.navigationBar.isHidden = false
//        let image = UIImage()
//        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
//        self.navigationController?.navigationBar.shadowImage = image
    }

    override func viewDidAppear(_: Bool) {
        setAction()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setInfoView.peopleView.image = UserDataManager.shared.userImage
        setInfoView.nameTextField.text = UserDataManager.shared.userData?.username
    }

    private func setAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(takeImage(reco:)))
        setInfoView.peopleView.addGestureRecognizer(tap)
    }

    @objc func takeImage(reco _: UITapGestureRecognizer) {
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
    @objc func save() {
        func updataUserName(_ userName: String) {
            SetInfoModelManerger.updateUserName(userName) {
                print("updata name")
                UserDataManager.shared.getUserData { _ in
                    self.stopLoading()
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        func errorType() {
            stopLoading()
            isEditing = false
            let ac = UIViewController.makeAlert("格式錯誤", "^([-_a-zA-Z0-9]{4,16})$") {}
            present(ac, animated: true, completion: nil)
        }
        func getUserName() {
            if let userName = setInfoView.nameTextField.text {
                if userName.isValidUserName {
                    updataUserName(userName)
                } else {
                    errorType()
                }
            } else {
                errorType()
            }
        }
        startLoading(self)
        if let image = setInfoView.peopleView.image {
            SetInfoModelManerger.updateUserImage(image) {
                print("updata Image")
                getUserName()
            }
        } else {
            print("not image")
            getUserName()
        }
    }
}

extension SetInfoVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            setInfoView.setPhoto(userImage: image)
        }

        view = setInfoView
        dismiss(animated: true, completion: nil)
    }
}
