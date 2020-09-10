//
//  LoginPageVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/2.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class LoginVC: UIViewController {
    //MARK:- Properties
    @IBOutlet weak var naviItem: UINavigationItem!
    
    @IBOutlet weak var signInBtn: CustomButton!
    
    @IBOutlet weak var signUpBtn: CustomButton!
    
    @IBOutlet weak var accountTF: CustomLogINTF!
    
    @IBOutlet weak var passwordTF: CustomLogINTF!
    //
    @IBOutlet weak var accountErrorLabel: UILabel!
    
    @IBOutlet weak var passwordErrorLabel: UILabel!
    //MARK:- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        propertiesSetting()
        naviBarSetting()
        IQKeyboardManager.shared.enable = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        accountTF.text = ""
        passwordTF.text = ""
    }
    //MARK:- Functions
    
    fileprivate func propertiesSetting() {
        accountTF.delegate = self
        accountTF.placeholder = "請輸入E-Mail"
        passwordTF.delegate = self
        passwordTF.placeholder = "請輸入密碼"
        signInBtn.backgroundColor = .mainColor2
        signUpBtn.backgroundColor = .mainColor
    }
    
    fileprivate func naviBarSetting(){
        let barAppearance =  UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance
        
    }
    
    func validateAccount()->[String:Any]?{
        if let account = accountTF.text , let password = passwordTF.text {
            if account.isValidEMail && password.isValidPassword{
                return ["password":password,"email":account]
            }
        }
        return nil
    }

    @IBAction func signInTapped(_ sender: CustomButton) {

        
        let test = ["password":"00000000", "email" : "ishida624@gmail.com"]
//        guard let parameters = validateAccount() else{ return }
        
        let request = HTTPRequest(endpoint: .userToken, method: .POST, contentType: .json, parameters: test)
        NetworkManager().sendRequest(with: request.send()) { (result:Result<LoginInReaponse,NetworkError>) in
            
            switch result{
            case .success(let decodedData):
                //存token
                guard let token = decodedData.loginData?.userToken else { return }
                UserToken.shared.updateToken(by: token)
                self.navigationController?.pushViewController(MainPageVC(), animated: true)
                
                
            case .failure(let err):
                self.present(.makeAlert(title: "錯誤", message: err.description, handler: {
                    self.dismiss(animated: true, completion: nil)
                }), animated: true)
            }
        }
        
    }
    
    @IBAction func signUpTapped(_ sender: CustomButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: StoryboardID.signUpVC.rawValue ) as! SignupVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

//MARK:- Textfield

extension LoginVC : UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case accountTF:
            passwordTF.becomeFirstResponder()
        default:
            self.view.endEditing(true)
            //TODO 執行登入
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case accountTF :
            accountErrorLabel.text = accountTF.text!.isValidEMail ? "" : "E-Mail格式錯誤"
        default:
            passwordErrorLabel.text = passwordTF.text!.isValidPassword ? "" : "密碼格式為8-12位數字與至少一個英文字母"
        }
    }
    
    
    
}

