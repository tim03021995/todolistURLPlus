import UIKit

class UserInfoVC: CanGetImageViewController, LoadAnimationAble {
    weak var delegate: RefreshDelegate!
    let userInformationView = UserInfoView()
    var email: String!
    convenience init(email: String) {
        self.init(nibName: nil, bundle: nil)
        self.email = email
    }

    override func loadView() {
        super.loadView()
        view = userInformationView
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        // getUserData(email: email)
        userInformationView.peopleView.image = UserDataManager.shared.userImage
        userInformationView.userNameLabel.text = UserDataManager.shared.userData?.username
        view = userInformationView
//        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance

        let tap = UITapGestureRecognizer(target: self, action: #selector(information))
        userInformationView.peopleView.addGestureRecognizer(tap)
    }

    override func viewWillDisappear(_: Bool) {
        delegate.refreshUserInfo()
    }

    @objc func information() {
        let vc = SetInfoVC()
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationItem.backBarButtonItem?.title = "返回"
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .white
    }

    private func setAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(information))
        userInformationView.peopleView.addGestureRecognizer(tap)
        userInformationView.userNameLabel.addGestureRecognizer(tap)
    }

    @objc func modifyPassword() {
        let vc = ModifyPasswordVC()
        navigationController?.navigationItem.backBarButtonItem?.title = "返回"
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .white
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func logout() {
        UserToken.clearToken()
        UserDataManager.shared.clearData()
        let presentingVC = presentingViewController
        dismiss(animated: false) {
            presentingVC?.dismiss(animated: false, completion: nil)
        }
    }

    func getUserData(email: String) {
        startLoading(self)
        UserInfoModelManager.getUserData(email: email) { userData in
            if let image = userData.image {
                self.getImage(type: .gill, imageURL: image) { image in
                    self.userInformationView.peopleView.image = image
                    self.stopLoading()
                }
            }
            self.userInformationView.userNameLabel.text = userData.username
        }
    }
}
