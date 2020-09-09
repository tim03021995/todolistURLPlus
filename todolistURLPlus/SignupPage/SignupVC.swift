//
//  SignupVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/3.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

//TODO 鍵盤位置 正則


class SignupVC: UIViewController {
    //MARK:- Properties
    
    @IBOutlet weak var userNameTF: CustomLogINTF!
    
    @IBOutlet weak var mailTF: CustomLogINTF!
    
    @IBOutlet weak var passwordTF: CustomLogINTF!
    
    @IBOutlet weak var checkPasswordTF: CustomLogINTF!
    //
    @IBOutlet weak var nameErrorLabel: UILabel!
    
    @IBOutlet weak var mailErrorLabel: UILabel!
    
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    @IBOutlet weak var checkPasswordErrorLabel: UILabel!
    
    //MARK:- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTF()
        
        //TODO 鍵盤上移事件
    }
    
    //MARK:- Functions
    
    fileprivate func settingTF() {
        userNameTF.delegate = self
        mailTF.delegate = self
        passwordTF.delegate = self
        checkPasswordTF.delegate = self
    }
    


    @IBAction func signupBtnTapped(_ sender: CustomButton) {
        //TODO 驗證正則
        
        //ＡＰＩ
        registerRequest()
        //跳頁
    }
    
    func registerRequest(){
        let parameters = ["username": "admin","password":"00000000","email" : "ishida624@gmail.com"]
        let request = HTTPRequest(endpoint: .register, method: .POST, parameters: parameters, contentType: .json)
        NetworkManager().sendRequest(with: request.send()) { (result:Result<ResponseStatus,NetworkError>) in
            switch result{
                
            case .success(let message):
                print(message)
            case .failure(let err):
                print(err)
            }
        }
    }
    
//    func validateTextField () -> String? {
//        if userNameTF.text == "" || mailTF.text == "" || passwordTF.text == "" || checkPasswordTF.text == "" {
//            return "輸入框不得為空白"
//        }else {
//            return nil
//        }
//        
//    }
    

    
}

extension SignupVC:UITextFieldDelegate{
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userNameTF:
            mailTF.becomeFirstResponder()
        case mailTF :
            passwordTF.becomeFirstResponder()
        case passwordTF:
            checkPasswordTF.becomeFirstResponder()
        default:
            self.view.endEditing(true)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case userNameTF:
            nameErrorLabel.text = userNameTF.text!.isValidName ? "" : "名稱字元必須介於2 - 16"
        case mailTF:
            mailErrorLabel.text = mailTF.text!.isValidEMail ? "" : "Email格式錯誤"
        case passwordTF:
            passwordErrorLabel.text = passwordTF.text!.isValidPassword ? "" : "密碼格式錯誤"
        case checkPasswordTF:
            checkPasswordErrorLabel.text = checkPasswordTF.text == passwordTF.text ? "" : "確認密碼與密碼不同"
        default:
            break
        }
    }
    
}
