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
    }
    //MARK:- Functions
    
    fileprivate func propertiesSetting() {
        accountTF.delegate = self
        passwordTF.delegate = self
        signInBtn.backgroundColor = .mainColor2
        signUpBtn.backgroundColor = .mainColor
        naviBarSetting()
    }
    
    fileprivate func naviBarSetting(){
        let barAppearance =  UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance
    }

    @IBAction func signInTapped(_ sender: CustomButton) {

    }
    
    @IBAction func signUpTapped(_ sender: CustomButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: StoryboardID.signUpVC.rawValue ) as! SignupVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK:- Textfield

extension LoginVC : UITextFieldDelegate{
    
    
    
    
}
