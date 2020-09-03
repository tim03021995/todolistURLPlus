//
//  LoginPageVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/2.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class LoginPageVC: UIViewController {
    //MARK:- Properties

    @IBOutlet weak var signInBtn: CustomButton!
    
    @IBOutlet weak var signUpBtn: CustomButton!
    
    @IBOutlet weak var accountTF: CustomLogINTF!
    
    @IBOutlet weak var passwordTF: CustomLogINTF!
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        accountTF.delegate = self
        passwordTF.delegate = self
        signInBtn.backgroundColor = .mainColor2
    }
    //MARK:- Functions

    @IBAction func signInTapped(_ sender: CustomButton) {
        
    }
    
    @IBAction func signUpTapped(_ sender: CustomButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: StoryboardID.signUpVC.rawValue ) as! SignupVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK:- Textfield

extension LoginPageVC : UITextFieldDelegate{
    
    
    
    
}
