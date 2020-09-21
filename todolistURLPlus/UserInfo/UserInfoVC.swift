import UIKit

class UserInfoVC: CanLoadViewController {
    let userInformationView = UserInfoView()
    override func loadView() {
        getUserData()
        super .loadView()
        self.view = userInformationView
    }
    override func viewDidLoad() {
        let api = Api()
        api.getUser()
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
    func getUserData(){
        let headers = ["userToken":UserToken.shared.userToken]
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .GET, headers: headers)
        NetworkManager().sendRequest(with: request.send()) { (result:Result<GetUserResponse,NetworkError>) in
            switch result {
            case .success(let data):
                print("get user Data success")
                let userData = data.userData
                if let image = userData.image{
                    self.getImage(type: .other, imageURL: image ) { (image) in
                        self.userInformationView.peopleView.image = image
                    }
                }
                self.userInformationView.userNameLabel.text = userData.username
            case .failure(let err):
                print(err)
            }
        }
    }
}
