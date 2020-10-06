//
//  LoginPageVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/2.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]
        
        // load our storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}


class LoginVC: UIViewController, Storyboarded {
    //MARK:- Properties

    
    @IBOutlet weak var rememberMeBTN: UIButton!
    
    @IBOutlet weak var naviItem: UINavigationItem!
    
    @IBOutlet weak var signInBtn: CustomButton!
    
    @IBOutlet weak var signUpBtn: CustomButton!
    
    @IBOutlet weak var accountTF: CustomLogINTF!
    
    @IBOutlet weak var passwordTF: CustomLogINTF!
    //
    @IBOutlet weak var accountErrorLabel: UILabel!
    
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    let loadIndicatorView:UIActivityIndicatorView = {
        var loading = UIActivityIndicatorView()
        loading.center = CGPoint(x: ScreenSize.centerX.value, y: ScreenSize.centerY.value)
        loading.color = .white
        loading.style = .large
        
        return loading
    }()
    
    let glass:UIView = {
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let glassView = UIVisualEffectView(effect: blurEffect)
        glassView.frame = CGRect(x:0, y:0, width: ScreenSize.width.value, height: ScreenSize.height.value)
        return glassView
    }()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        propertiesSetting()
        IQKeyboardManager.shared.enable = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        accountTF.text = UserDefaults.standard.getUserAccount()
        rememberMeBTN.isSelected = UserDefaults.standard.isLoggedIn()

//        accountTF.text = "alvin@gmail.com"
//        passwordTF.text = "a00000000"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //set userdefault
        if rememberMeBTN.isSelected{
            UserDefaults.standard.saveAccount(account: accountTF.text ?? "")
        }else {
            UserDefaults.standard.saveAccount(account: "")
        }
        UserDefaults.standard.setIsLoggedInStatus(status: rememberMeBTN.isSelected)
    }
    //MARK:- Functions
  
    fileprivate func propertiesSetting() {
        rememberMeBTN.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        rememberMeBTN.setImage(UIImage(systemName: "square"), for: .normal)
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
        startLoading()
        //驗證帳密 , 成功的話包裝
        guard let parameters = validateAccount() else{ return }
        //包裝需要的參數
        let getTokenRequest = HTTPRequest(endpoint: .userToken, contentType: .json, method: .POST, parameters: parameters).send()
        
        NetworkManager().sendRequest(with: getTokenRequest) { (result:Result<LoginInReaponse,NetworkError>) in
            
            switch result{
                
            case .success(let decodedData):
                self.signInBtn.isEnabled = true
                //存token
                guard let token = decodedData.loginData?.userToken else {return}
                UserToken.updateToken(by: token)
                let vc = MainPageVC()
                vc.modalPresentationStyle = .fullScreen
                self.stopLoading()
                self.present(vc, animated: true) 
                
            case .failure(let err):
                self.stopLoading()
                self.signInBtn.isEnabled = true
                self.present(.makeAlert("Error", err.errMessage, {
                }), animated: true)
                print(err.description)
            }
        }
    }
    
    @IBAction func rememberTapped(_ sender: UIButton) {
        rememberMeBTN.isSelected = !rememberMeBTN.isSelected
    }
    
    @IBAction func signInTapped(_ sender: CustomButton) {
        signInBtn.isEnabled = false
        signIn()
    }
    
    @IBAction func signUpTapped(_ sender: CustomButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: StoryboardID.signUpVC ) as! SignupVC
        present(vc, animated: true, completion: nil)
        
    }
    
    func startLoading(){
        glass.alpha = 0.5
        self.view.addSubview(glass)
        self.view.addSubview(loadIndicatorView)
        loadIndicatorView.startAnimating()
        let animate = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
            self.glass.alpha = 1
        }
        animate.startAnimation()
    }
    
    func stopLoading(){
        let animate = UIViewPropertyAnimator(duration: 3, curve: .easeIn) {
            self.glass.alpha = 0
        }
        animate.addCompletion { (position) in
            if position == .end {
                self.loadIndicatorView.removeFromSuperview()
                self.glass.removeFromSuperview()
            }
        }
        animate.startAnimation()
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


