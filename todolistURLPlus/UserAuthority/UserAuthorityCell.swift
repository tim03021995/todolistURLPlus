//
//  UserAuthorityCellTableViewCell.swift
//  todolistURLPlus
//
//  Created by 陳冠諭 on 2020/9/15.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

class UserAuthorityCell: UITableViewCell {
    
    var cellTitleLabel = UILabel()
    var headShot = UserImageFactory.makeImageView(size: .small, image: UIImage(named: "single")! )
    var backGroundView = UIView()
    var fullScreenMaxX = UIScreen.main.bounds.maxX
    var fullScreenMaxY = UIScreen.main.bounds.maxY
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        setHeadShot()
        setTitleLabel()
        setHeadShotConstriants()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been imp;emented")
    }
    
    func updateCell(indexPath:IndexPath, data: [GetGroupResponse.UserData]){
        let  fullScreenMaxX = UIScreen.main.bounds.maxX
        backgroundColor = .white
        layer.borderWidth = 5
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = fullScreenMaxX * 0.06
        contentView.layer.borderWidth = 5
        contentView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentView.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        contentView.layer.cornerRadius = fullScreenMaxX * 0.06
        clipsToBounds = true
        cellTitleLabel.text = data[indexPath.row].username
        if let imageUrl = data[indexPath.row].image {
            CanGetImageViewController().getImage(type: .gill, imageURL: imageUrl) { (image) in
                self.headShot.image = image
            }
        }else {
            headShot.image = UIImage(named: "single")
        }
    }
    ///for SearchVC
    func updateSearchTBCell(indexPath:IndexPath, data: [GetUserResponse.UserData]){
        backgroundColor = .clear
        layer.cornerRadius = fullScreenMaxX * 0.06
        contentView.layer.borderWidth = 5
        contentView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentView.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        contentView.layer.cornerRadius = fullScreenMaxX * 0.06
        clipsToBounds = true
        cellTitleLabel.text = data[indexPath.row].username
        if let imageURL = data[indexPath.row].image {
            CanGetImageViewController().getImage(type: .gill, imageURL: imageURL) { (image) in
                self.headShot.image = image
            }
        }else {
            self.headShot.image = UIImage(named: "single")
        }
    }
    
    
    func setTitleLabel(){
        cellTitleLabel.backgroundColor = .clear
            contentView.addSubview(cellTitleLabel)
    }
    
    func setHeadShot() {
        headShot.clipsToBounds = true
        headShot.layer.cornerRadius = fullScreenMaxY * 0.04
        contentView.addSubview(headShot)
    }
    
    func setTitleLabelConstraints(){
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cellTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellTitleLabel.leadingAnchor.constraint(equalTo: headShot.trailingAnchor, constant: 10).isActive = true
    }
    
    func setHeadShotConstriants(){
        headShot.translatesAutoresizingMaskIntoConstraints = false
        headShot.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        headShot.widthAnchor.constraint(equalToConstant: fullScreenMaxY * 0.08).isActive = true
        headShot.heightAnchor.constraint(equalToConstant: fullScreenMaxY * 0.08 ).isActive = true
        headShot.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
    }
    
    func setHeadShotConstriants1(){
        headShot.translatesAutoresizingMaskIntoConstraints = false
        headShot.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        headShot.widthAnchor.constraint(equalToConstant: fullScreenMaxY * 0.03).isActive = true//0.2
        headShot.heightAnchor.constraint(equalToConstant: fullScreenMaxY * 0.03 ).isActive = true
        headShot.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
    }
    
    //改變minus buttom位置，往左邊移一點
    override func layoutSubviews() {
        super.layoutSubviews()
        for subview in self.subviews {
            if subview.isMember(of: NSClassFromString("UITableViewCellEditControl")!) {
                var newFrame: CGRect = subview.frame
                newFrame.origin.x = 3.3
                subview.frame = newFrame
            }
        }
    }
    
    
}


