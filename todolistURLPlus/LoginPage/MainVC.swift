//
//  MainVC.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/15.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class MainVC: UIViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let token = UserToken.getToken() {
            let headers = ["userToken":token]
            let request = HTTPRequest(endpoint: .card, contentType: .json, method: .GET, headers: headers).send()
            NetworkManager().sendRequest(with: request) { (res:Result<GetCardResponse,NetworkError>) in
                switch res{
                case .success(_):
                    let vc = MainPageVC()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false, completion: nil )
                case .failure(let err):
                    self.shouldRefreshToken()
                        print(err.description)
                }
            }
        }else {
            let vc = LoginVC.instantiate()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false , completion: nil)

        }
        
//                if UserToken.getToken() == nil  {
//                    let vc = LoginVC.instantiate()
//                    vc.modalPresentationStyle = .fullScreen
//                    present(vc, animated: false , completion: nil)
//                }
//                else{
//                    let vc = MainPageVC()
//                    vc.modalPresentationStyle = .fullScreen
//                    present(vc, animated: false, completion: nil )
//                }
    }
}
