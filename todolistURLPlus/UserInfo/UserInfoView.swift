import UIKit

class UserInfoView: UIView {
    private var backgroundImage : UIImageView = {
        return BackGroundFactory.makeImage(type: .background1)
    }()
    private var glassView : UIVisualEffectView = {
        var glassView = GlassFactory.makeGlass()
        return glassView
    }()
    var peopleView:UIImageView = {
        var imageView = UserImageFactory.makeImageView(size: .medium, image: nil)
        imageView.backgroundColor = .gray
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    var userNameLabel:UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width:ScreenSize.width.value * 0.4 , height: ScreenSize.height.value * 0.1))
        label.textAlignment = .center
        label.text = "Name"
        label.font = .systemFont(ofSize: 40)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.isUserInteractionEnabled = true
        return label
    }()
    private var informationButton:UIButton = {
        var button = ButtonFactory.makeButton(type: .normal, text: "information")
        button.addTarget(self, action: #selector(UserInfoVC.information), for: .touchUpInside)
        return button
    }()
    private var modifyPasswordButton:UIButton = {
        var button = ButtonFactory.makeButton(type: .normal, text:
            "modify password")
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(nil, action: #selector(UserInfoVC.modifyPassword), for: .touchUpInside)
        return button
    }()
    private var logoutButton:UIButton = {
        var button = ButtonFactory.makeButton(type: .cancel, text: "logout")
        button.addTarget(self , action: #selector(UserInfoVC.logout), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setSubView()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubView(){
        //addSubview(backgroundImage)
        addSubview(glassView)
        addSubview(peopleView)
        addSubview(userNameLabel)
        addSubview(informationButton)
        addSubview(modifyPasswordButton)
        addSubview(logoutButton)
    }
    private func setConstraints(){
        let centerX = ScreenSize.centerX.value
        let space = ScreenSize.spaceY.value
        let glassViewTop = glassView.frame.minY
        let glassViewBotton = ScreenSize.centerY.value + ScreenSize.height.value * 0.04 + glassView.frame.height * 0.5
        peopleView.center = CGPoint(
            x: centerX,
            y: glassViewTop + peopleView.frame.height * 0.5 + space * 4)
        userNameLabel.center = CGPoint(
            x: centerX,
            y: peopleView.frame.maxY + userNameLabel.frame.height * 0.5 + space )
        informationButton.center = CGPoint(
            x: centerX,
            y: userNameLabel.frame.maxY + informationButton.frame.height * 0.5 + space * 1.5)
        modifyPasswordButton.center = CGPoint(
            x: centerX,
            y: informationButton.frame.maxY + modifyPasswordButton.frame.height * 0.5 + space)
        logoutButton.center = CGPoint(
            x: centerX,
            y: glassViewBotton - logoutButton.frame.height * 0.5 - space * 5)
    }
    func setUserData(userImage:UIImage,userName:String){
            self.peopleView.image = userImage
            self.userNameLabel.text = userName
    }
}
