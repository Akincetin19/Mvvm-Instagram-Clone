//
//  PofileHeaderCell.swift
//  Mvvm-Instagram-Clone
//
//  Created by Akın Çetin on 6.12.2022.
//

import UIKit
import SDWebImage
import Firebase

protocol ProfileHeaderCellInterface {
    func configureImg()
    func configureBtnGrid()
    func configureBtnList()
    func createStackView()
    func configureBtn()
    func configureBtnSetTitle()
    func configureUsernameLabel()
    func configureTotalPostsLabel()
    func configureTotalFollowers()
    func configureTotalFollowing()
    func creteUserInfoStackView()
    
}
final class ProfileHeaderCell: UICollectionViewCell {
    
    private var btnGrid : UIButton!
    private var btnList: UIButton!
    private var btnSetProfile: UIButton!
    private var profileImg : UIImageView!
    private var btn: UIButton!
    private var userNameLabel: UILabel!
    private var totalPostsLabel: UILabel!
    private var totalFollowersLabel: UILabel!
    private var totalFollowingLabel: UILabel!
    private var currentUser : User?
    var user : User? {
        didSet {
            guard let user = user else {return}
            guard let url = URL(string: user.profilePictureUrl) else {return}
            self.profileImg.sd_setImage(with: url, completed: nil)
            self.userNameLabel.text = user.userName
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImg()
        configureBtnGrid()
        configureBtnList()
        configureBtn()
        createStackView()
        configureUsernameLabel()
        configureTotalPostsLabel()
        configureTotalFollowers()
        configureTotalFollowing()
        creteUserInfoStackView()
        configureBtnSetTitle()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ProfileHeaderCell: ProfileHeaderCellInterface {
    func configureTotalPostsLabel() {
        totalPostsLabel = UILabel()
        totalPostsLabel.text = "10\nGönderiler"
        totalPostsLabel.textAlignment = .center
        totalPostsLabel.numberOfLines = 0
    }
    func configureTotalFollowers() {
        totalFollowersLabel = UILabel()
        totalFollowersLabel.text = "10\nTakipçi"
        totalFollowersLabel.textAlignment = .center
        totalFollowersLabel.numberOfLines = 0
    }
    func configureTotalFollowing() {
        totalFollowingLabel = UILabel()
        totalFollowingLabel.text = "10\nTakip"
        totalFollowingLabel.numberOfLines = 0
        totalFollowingLabel.textAlignment = .center
        print("10\nTakip")
    }
    func creteUserInfoStackView() {
        let stackView = UIStackView(arrangedSubviews: [totalPostsLabel , totalFollowersLabel, totalFollowingLabel])
        addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.anchor(top: topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, height: 50, width: 0, paddingTop: 37.5, paddingLeft: 120, paddingRight: -20, paddingBottom: 0)
    }
    func configureBtnSetTitle() {
        btnSetProfile = UIButton(type: .system)
        addSubview(btnSetProfile)
        btnSetProfile.layer.borderColor = UIColor.lightGray.cgColor
        btnSetProfile.layer.borderWidth = 1
        btnSetProfile.setTitle("Profili Düzenle", for: .normal)
        btnSetProfile.layer.cornerRadius = 6
        btnSetProfile.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, height: 35, width: 0, paddingTop: 100, paddingLeft: 120, paddingRight: -20, paddingBottom: 10)
    }
    func configureUsernameLabel() {
        userNameLabel = UILabel()
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        addSubview(userNameLabel)
        userNameLabel.anchor(top: profileImg.bottomAnchor, bottom: btnGrid.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, height: 20, width: 0, paddingTop: 5, paddingLeft: 15, paddingRight: 15, paddingBottom: 0)
    }
    func configureImg() {
        profileImg = UIImageView()
        addSubview(profileImg)
        profileImg.anchor(top: topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: nil , height: 90, width: 90, paddingTop: 15, paddingLeft: 15, paddingRight: 0, paddingBottom: 0)
        profileImg.layer.cornerRadius  = 45
        profileImg.clipsToBounds = true
    }
    
    func configureBtnGrid() {
        btnGrid = UIButton(type: .system)
        btnGrid.setImage(#imageLiteral(resourceName: "Izgara"), for: .normal)
        addSubview(btnGrid)
    }
    func configureBtnList() {
        btnList = UIButton(type: .system)
        btnList.setImage(#imageLiteral(resourceName: "Liste"), for: .normal)
        addSubview(btnList)
        btnList.tintColor = UIColor(white: 0, alpha: 0.2)
    }
    func configureBtn() {
        btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "Yer_Isareti"), for: .normal)
        addSubview(btn)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
    }
    func createStackView() {
        
        let topLine = UIView()
        topLine.backgroundColor = .lightGray
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        addSubview(topLine)
        addSubview(bottomLine)
        let stackView = UIStackView(arrangedSubviews: [btnGrid, btnList, btn])
        addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.anchor(top: nil, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, height: 60, width: 0, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 10)
        topLine.anchor(top: stackView.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, height: 0.5, width: 0, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0)
        bottomLine.anchor(top: nil, bottom: stackView.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, height: 0.5, width: 0, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: -15)
        
    }
    
}
