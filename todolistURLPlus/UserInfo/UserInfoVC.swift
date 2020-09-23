import UIKit

class UserInfoVC: CanGetImageViewController {
    let userInformationView = UserInfoView()
    override func loadView() {
        super .loadView()
        getUserData()
        self.view = userInformationView
    }
    override func viewWillAppear(_ animated: Bool) {
        getUserData()
        self.view = userInformationView
    }
    override func viewDidLoad() {
        Api().getUser()
        super.viewDidLoad()
        
    }
    @objc func information (){
        let vc = SetInfoVC()
        vc.setUserData(
            userImage: userInformationView.peopleView.image,
            userName: userInformationView.userNameLabel.text)
       // vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
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
    func getUserData(){
        let headers = ["userToken":UserToken.shared.userToken]
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .GET, headers: headers)
        NetworkManager.sendRequest(with: request.send()) { (result:Result<GetUserResponse,NetworkError>) in
            switch result {
            case .success(let data):
                print("get user Data success")
                let userData = data.userData
                if let image = userData.image{
                    self.getImage(type: .gill, imageURL: image ) { (image) in
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
