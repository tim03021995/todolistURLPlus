import UIKit

import UIKit

class UserInfoVC: UIViewController {
    let userInformationView = UserInfoView()
    override func loadView() {
        super .loadView()
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
    func setUserData(userImage:UIImage?, userName: String?){
        userInformationView.setUserData(
            userImage: userImage ?? UIImage(systemName: "photo")!,
            userName: userName ?? "Unknow")
        self.view = userInformationView
    }
}
