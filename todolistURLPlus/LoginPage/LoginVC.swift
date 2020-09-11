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
        
        IQKeyboardManager.shared.enable = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        accountTF.text = "test@test.com"
        passwordTF.text = "test12345"
    }
    //MARK:- Functions
    
    
    
    fileprivate func propertiesSetting() {
        naviBarSetting()
        accountTF.delegate = self
        accountTF.placeholder = "E-Mail"
        passwordTF.delegate = self
        passwordTF.placeholder = "Password"
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
    
    func signIn(){
        //驗證帳密 , 成功的話包裝
        guard let parameters = validateAccount() else{ return }
        
        //包裝需要的參數
        let getTokenRequest = HTTPRequest(endpoint: .userToken, method: .POST, parameters: parameters)
        
        NetworkManager().sendRequest(with: getTokenRequest.send()) { (result:Result<LoginInReaponse,NetworkError>) in
            
            switch result{
                
            case .success(let decodedData):
                
                if let err = decodedData.error{
                    print(err)
                }else{
                    //存token
                    guard let token = decodedData.loginData?.userToken else { return }
                    UserToken.shared.updateToken(by: token)
                    self.navigationController?.pushViewController(MainPageVC(), animated: true)                }
                
                
            case .failure(let err):
                self.present(.makeAlert(title: "Error", message: err.description, handler: {
                    self.dismiss(animated: true, completion: nil)
                }), animated: true)
            }
        }
    }
    
    @IBAction func signInTapped(_ sender: CustomButton) {
        signIn()
    }
    
    @IBAction func signUpTapped(_ sender: CustomButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: StoryboardID.signUpVC.rawValue ) as! SignupVC
        present(vc, animated: true, completion: nil)
        
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
            signIn()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case accountTF :
            accountErrorLabel.text = accountTF.text!.isValidEMail ? "" : "E-Mail's format wrong "
        default:
            passwordErrorLabel.text = passwordTF.text!.isValidPassword ? "" : "密碼格式錯誤,必須8-12字,包含數字與至少一個英文字母"
        }
    }
    
    
    
}

