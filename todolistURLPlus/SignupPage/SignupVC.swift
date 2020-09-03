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
    
    //MARK:- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTF()
    }
    
    //MARK:- Functions
    
    fileprivate func settingTF() {
        userNameTF.delegate = self
        mailTF.delegate = self
        passwordTF.delegate = self
        checkPasswordTF.delegate = self
    }
    


    @IBAction func signupBtnTapped(_ sender: CustomButton) {
    }
    
}

extension SignupVC:UITextFieldDelegate{
    
}
