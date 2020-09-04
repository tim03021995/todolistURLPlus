import UIKit

import UIKit

class UserInfoVC: UIViewController {
    override func loadView() {
        super .loadView()
        let userInformationView = UserInfoView()
        userInformationView.setUserData(userImage: nil, userName: nil)
        self.view = userInformationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @objc func information (){
        let vc = SetInfoVC()
        show(vc, sender: nil)
    }
    @objc func modifyPassword(){
        
    }
}
