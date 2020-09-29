//
//  ForgotPasswordVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/9.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class ForgotPasswordVC: CanGetImageViewController {
    let forgotPasswordView = ForgotPasswordView()
    override func loadView() {
        super .loadView()
        forgotPasswordView.nameTextField.delegate = self
        self.view = forgotPasswordView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @objc func touchConfirmButton(){
        loading()
        ForgotPasswordModel.updateUserPassword {
            self.dismiss(animated: true, completion: nil)
            self.stopLoading()
        }
    }



}
extension ForgotPasswordVC:UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
//        forgotPasswordView.nameTextField = passwordTF.text!.isValidPassword ? "" : "密碼格式錯誤"
    }
}
