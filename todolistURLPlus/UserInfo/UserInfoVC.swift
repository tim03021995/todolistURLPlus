import UIKit

class UserInfoVC: CanGetImageViewController {
    let userInformationView = UserInfoView()
    var email:String!
    convenience init(email:String){
        self.init(nibName:nil,bundle:nil)
        self.email = email
    }
    override func loadView() {
        super .loadView()
        self.view = userInformationView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getUserData(email: email)
        self.view = userInformationView
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(information))
        userInformationView.peopleView.addGestureRecognizer(tap)
    }
    @objc func information (){
        let vc = SetInfoVC()
        vc.setUserData(
            userImage: userInformationView.peopleView.image,
            userName: userInformationView.userNameLabel.text)
                navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationItem.backBarButtonItem?.title = "返回"
    }
    private func setAction(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(information))
            userInformationView.peopleView.addGestureRecognizer(tap)
            userInformationView.userNameLabel.addGestureRecognizer(tap)

    }
    @objc func modifyPassword(){
        
    }
    @objc func logout(){
        UserToken.shared.clearToken()

        let presentingVC = self.presentingViewController
        dismiss(animated: false) {
            presentingVC?.dismiss(animated: false, completion: nil)
        }
    }
    func getUserData(email:String){
        UserInfoModelManager.getUserData(email: email) { (userData) in
            if let image = userData.image{
                self.getImage(type: .gill, imageURL: image ) { (image) in
                    self.userInformationView.peopleView.image = image
                }
            }
            self.userInformationView.userNameLabel.text = userData.username
        }
    }

}
