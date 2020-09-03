//
//  LoginPageVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/2.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    //MARK:- Properties
    @IBOutlet weak var naviItem: UINavigationItem!
    
    @IBOutlet weak var signInBtn: CustomButton!
    
    @IBOutlet weak var signUpBtn: CustomButton!
    
    @IBOutlet weak var accountTF: CustomLogINTF!
    
    @IBOutlet weak var passwordTF: CustomLogINTF!
    
    //MARK:- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        propertiesSetting()
        naviBarSetting()
        
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
    
    func validateAccount(){
        if accountTF.text == "" || passwordTF.text == "" {
            //alert
            present(.makeAlert(title: "test", message: "test", handler: {
                print("123")
            }), animated: true)
        }
    }

    @IBAction func signInTapped(_ sender: CustomButton) {
        validateAccount()
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
    
}

