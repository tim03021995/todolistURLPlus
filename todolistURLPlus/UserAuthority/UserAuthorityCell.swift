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
    var headShot = UIImageView()
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
    
    
    func setCell(indexPath:IndexPath, data: [String]){
        self.backgroundColor = .clear
        self.layer.borderWidth = 5
        self.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.layer.cornerRadius = fullScreenMaxX * 0.06
        self.contentView.layer.borderWidth = 5
        self.contentView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.contentView.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        self.contentView.layer.cornerRadius = fullScreenMaxX * 0.06
        self.clipsToBounds = true
        self.cellTitleLabel.text = data[indexPath.row]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been imp;emented")
    }
    
    func setTitleLabel(){
        cellTitleLabel.backgroundColor = .clear
        addSubview(cellTitleLabel)
    }
    
    func setHeadShot() {
        headShot.image = UIImage(named: "joey")
        headShot.clipsToBounds = true
        headShot.layer.cornerRadius = fullScreenMaxY * 0.04
        addSubview(headShot)
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


