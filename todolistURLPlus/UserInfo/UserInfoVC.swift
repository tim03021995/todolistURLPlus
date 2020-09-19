import UIKit

class UserInfoVC: CanLoadViewController {
    let userInformationView = UserInfoView()
    override func loadView() {
        super .loadView()
        var  urlString = "https://i.pinimg.com/originals/df/80/f3/df80f367ffb8669baeabcd5564f1b638.jpg"
        //var  urlString ="http://35.185.131.56:8002/images/task/2020-09-18%2017:32:45%20task141.jpeg"

        getImage(type: .other, imageURL: urlString) { (image) in
            self.userInformationView.peopleView.image = image
        }
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
    func getUserData(){
        let headers = ["userToken":UserToken.shared.userToken]
        let request = HTTPRequest(endpoint: .user, contentType: .json, method: .GET, headers: headers)
        NetworkManager().sendRequest(with: request.send()) { (result:Result<GetUserResponse,NetworkError>) in
            switch result {
            case .success(let a):
                print("get user Data success")
                print(a)
            case .failure(let err):
                print(err)
            }
        }
    }
}
