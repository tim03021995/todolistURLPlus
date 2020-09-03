import UIKit

import UIKit

class UserInformationViewController: UIViewController {
    override func loadView() {
        super .loadView()
        let userInformationView = UserInfomationView()
        userInformationView.setUserData(userImage: nil, userName: nil)
        self.view = userInformationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @objc func information (){
        
    }
    @objc func modifyPassword(){
        
    }
}
