import UIKit

class UserInfoVC: UIViewController {
    let userInformationView = UserInfoView()
    override func loadView() {
        #warning("get")
        super .loadView()
        self.view = userInformationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @objc func information (){
        let vc = SetInfoVC()
        vc.setUserData(
            userImage: userInformationView.peopleView.image,
            userName: userInformationView.userNameLabel.text)
        show(vc, sender: nil)
    }
    @objc func modifyPassword(){
        
    }
    @objc func logoutOut(){
        UserToken.shared.clearToken()

        let presentingVC = self.presentingViewController
        dismiss(animated: true) {
            presentingVC?.dismiss(animated: true, completion: nil)
        }
    }

}
