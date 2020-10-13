//
//  LoginPageVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/2.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class LoginVC: UIViewController, Storyboarded {
    //MARK:- Properties
    let loadingManger = LoadingManager()
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var rememberMeBTN: UIButton!
    @IBOutlet weak var naviItem: UINavigationItem!
    @IBOutlet weak var signInBtn: CustomButton!
    @IBOutlet weak var signUpBtn: CustomButton!
    @IBOutlet weak var accountTF: CustomLogINTF!
    @IBOutlet weak var passwordTF: CustomLogINTF!
    @IBOutlet weak var accountErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    

    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        propertiesSetting()
        IQKeyboardManager.shared.enable = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        accountTF.text = UserDefaults.standard.getUserAccount()
        rememberMeBTN.isSelected = UserDefaults.standard.isLoggedIn()
        passwordTF.text = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.saveAccount(account: rememberMeBTN.isSelected ? accountTF.text ?? "" : "")
        
        UserDefaults.standard.setIsLoggedInStatus(status: rememberMeBTN.isSelected)
    }
    //MARK:- Functions
    
    fileprivate func propertiesSetting() {
        eyeBtn.setImage(UIImage(systemName: "eye"), for: .selected)
        eyeBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        
        rememberMeBTN.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .selected)
        rememberMeBTN.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
        accountTF.delegate = self
        accountTF.placeholder = "E-Mail"
        passwordTF.delegate = self
        passwordTF.placeholder = "Password"
        signInBtn.backgroundColor = .mainColor2
        signUpBtn.backgroundColor = .mainColor
    }
    
    
    private func validateAccount()->[String:Any]?{
        if let account = accountTF.text , let password = passwordTF.text {
            if account.isValidEMail && password.isValidPassword{
                return ["password":password,"email":account]
            }else {
                present(.makeAlert("Error", "請輸入正確帳號密碼", {
                }) ,animated: true)
            }
        }
        return nil
    }
    
    private func signIn(){
        signInBtn.isEnabled = false
        //驗證帳密 , 成功的話包裝
        guard let parameters = validateAccount() else{
            signInBtn.isEnabled = true
            return }
        let getTokenRequest = HTTPRequest(endpoint: .userToken, contentType: .json, method: .POST, parameters: parameters).send()
        loadingManger.startLoading(vc: self)
        NetworkManager().sendRequest(with: getTokenRequest) { (result:Result<LoginInReaponse,NetworkError>) in
            
            switch result{
            
            case .success(let decodedData):
                self.signInBtn.isEnabled = true
                guard let token = decodedData.loginData?.userToken else {return}
                UserToken.updateToken(by: token)
                let vc = MainPageVC(.fullScreen, nil)
                self.present(vc, animated: false)
                
            case .failure(let err):
                self.signInBtn.isEnabled = true
                self.present(.makeAlert("Error", err.errMessage, {
                }), animated: true)
                print(err.description)
            }
            self.loadingManger.stopLoading()
        }
    }
    
    @IBAction func rememberTapped(_ sender: UIButton) {
        rememberMeBTN.isSelected = !rememberMeBTN.isSelected
    }
    
    @IBAction func signInTapped(_ sender: CustomButton) {
        signIn()
    }
    
    @IBAction func signUpTapped(_ sender: CustomButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: StoryboardID.signUpVC ) as! SignupVC
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func eyeTapped(_ sender: UIButton) {
        eyeBtn.isSelected = !eyeBtn.isSelected
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
    }
    
//    func startLoading(){
//        glass.alpha = 0
//        self.view.addSubview(glass)
//        self.view.addSubview(loadIndicatorView)
//        loadIndicatorView.startAnimating()
//        let animate = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
//            self.glass.alpha = 1
//        }
//        animate.startAnimation()
//    }
//
//    func stopLoading(){
//        let animate = UIViewPropertyAnimator(duration: 3, curve: .easeIn) {
//            self.glass.alpha = 0.1
//        }
//        animate.addCompletion { (position) in
//            if position == .end {
//                self.loadIndicatorView.removeFromSuperview()
//                self.glass.removeFromSuperview()
//            }
//        }
//        animate.startAnimation()
//    }
    
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        
        switch textField {
        case passwordTF:
            passwordErrorLabel.text = count > 12 ? "密碼不可超過12個字元" : ""
            return count <= 12
        default:
            break
        }
        return true
    }
    
    
}


