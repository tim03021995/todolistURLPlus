//
//  ForgotPasswordVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/9.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class ModifyPasswordVC: CanGetImageViewController, LoadAnimationAble {
    let forgotPasswordView = ModifyPasswordView()
    override func loadView() {
        super.loadView()
        forgotPasswordView.passwordTextField.delegate = self
        view = forgotPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        let image = UIImage()
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = image
    }

    @objc func touchConfirmButton() {
        if let password = forgotPasswordView.passwordTextField.text {
            if password.isValidPassword {
                updataPassWord(password)
            } else {
                forgotPasswordView.passwordTextField.text = ""
            }
        }
    }

    func updataPassWord(_ password: String) {
        startLoading(self)
        ModifyPasswordModel.updateUserPassword(password: password) { result in
            switch result {
            case .success:
                print("update success")
                self.dismiss(animated: true, completion: nil)
                self.stopLoading()
            case let .failure(err):

                print("update error")
                print(err.description)
                self.forgotPasswordView.alertLabel.text = err.errMessage
                self.stopLoading()
                // print("錯誤訊息：\(err.errMessage)")
            }
        }
    }
}

extension ModifyPasswordVC: UITextFieldDelegate {
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_: UITextField) {
        let animate = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
            self.forgotPasswordView.alertLabel.alpha = self.forgotPasswordView.passwordTextField.text!.isValidPassword ? 0 : 1
        }
        animate.startAnimation()
    }
}
