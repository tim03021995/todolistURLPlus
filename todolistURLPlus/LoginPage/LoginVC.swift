//
//  LoginPageVC.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/9/2.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import IQKeyboardManagerSwift
import UIKit

class LoginVC: UIViewController, Storyboarded, LoadAnimationAble {
    // MARK: - Properties

    @IBOutlet var eyeBtn: UIButton!
    @IBOutlet var rememberMeBTN: UIButton!
    @IBOutlet var naviItem: UINavigationItem!
    @IBOutlet var signInBtn: CustomButton!
    @IBOutlet var signUpBtn: CustomButton!
    @IBOutlet var accountTF: CustomLogINTF!
    @IBOutlet var passwordTF: CustomLogINTF!
    @IBOutlet var accountErrorLabel: UILabel!
    @IBOutlet var passwordErrorLabel: UILabel!

    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        propertiesSetting()
        IQKeyboardManager.shared.enable = true
    }

    override func viewWillAppear(_: Bool) {
        accountTF.text = UserDefaults.standard.getUserAccount()
        rememberMeBTN.isSelected = UserDefaults.standard.isLoggedIn()
        passwordTF.text = ""
    }

    override func viewWillDisappear(_: Bool) {
        UserDefaults.standard.saveAccount(account: rememberMeBTN.isSelected ? accountTF.text ?? "" : "")

        UserDefaults.standard.setIsLoggedInStatus(status: rememberMeBTN.isSelected)
    }

    // MARK: - Functions

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

    private func validateAccount() -> [String: Any]? {
        if let account = accountTF.text, let password = passwordTF.text {
            if account.isValidEMail, password.isValidPassword {
                return ["password": password, "email": account]
            } else {
                present(.makeAlert("Error", "請輸入正確帳號密碼") {}, animated: true)
            }
        }
        return nil
    }

    private func signIn() {
        signInBtn.isEnabled = false
        // 驗證帳密 , 成功的話包裝
        guard let parameters = validateAccount() else {
            signInBtn.isEnabled = true
            return
        }
        startLoading(self)
        let getTokenRequest = HTTPRequest(endpoint: .userToken, contentType: .json, method: .POST, parameters: parameters).send()
        NetworkManager().sendRequest(with: getTokenRequest) { (result: Result<LoginInReaponse, NetworkError>) in

            switch result {
            case let .success(decodedData):
                self.signInBtn.isEnabled = true
                guard let token = decodedData.loginData?.userToken else { return }
                UserToken.updateToken(by: token)
                let vc = MainPageVC(.fullScreen, nil)
                self.present(vc, animated: false)

            case let .failure(err):
                self.stopLoading()
                self.signInBtn.isEnabled = true
                self.present(.makeAlert("Error", err.errMessage) {}, animated: true)
                print(err.description)
            }
        }
    }

    @IBAction func rememberTapped(_: UIButton) {
        rememberMeBTN.isSelected = !rememberMeBTN.isSelected
    }

    @IBAction func signInTapped(_: CustomButton) {
        signIn()
    }

    @IBAction func signUpTapped(_: CustomButton) {
        let vc = storyboard?.instantiateViewController(identifier: StoryboardID.signUpVC) as! SignupVC
        present(vc, animated: true, completion: nil)
    }

    @IBAction func eyeTapped(_: UIButton) {
        eyeBtn.isSelected = !eyeBtn.isSelected
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
    }
}

// MARK: - Textfield

extension LoginVC: UITextFieldDelegate {
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case accountTF:
            passwordTF.becomeFirstResponder()
        default:
            view.endEditing(true)
            signIn()
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case accountTF:
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
