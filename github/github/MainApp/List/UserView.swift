//
//  UserView.swift
//  github
//
//  Created by Marek Piotrowski-EXT on 28/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//

import UIKit

class UserView: UIView {
    private let userName = UILabel()
    private let userType = UILabel()
    private let userImage = UIImageView()
    private let margin = 4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        func prepareLabel(_ label: UILabel) {
            label.textColor = GithubColors.Table.user
            label.font = GithubFonts.Table.user
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            addSubview(label)
        }
        prepareLabel(userName)
        prepareLabel(userType)
        addSubview(userImage)
        
        userImage.layer.cornerRadius = 8
        userImage.clipsToBounds = true
    }
    
    func setupConstraints() {
        userImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalTo(userImage.snp.height)
        }
        
        userName.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(userImage.snp.bottom).offset(margin)
        }
        
        userType.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(userName.snp.bottom).offset(margin)
            make.bottom.equalToSuperview()
        }
    }
    
    func fillUserInformation(user: Owner?) {
        userName.text = user?.login
        userType.text = user?.type
    }
    
    func setImageForUser(_ image: UIImage?) {
        userImage.image = image
        startAnimation(view: userImage)
    }
    
    func clearView() {
        userImage.image = nil
        userName.text = nil
        userType.text = nil
    }
    
    func startAnimation(view: UIView) {
        let anim = CABasicAnimation(keyPath: "transform.scale")
        anim.duration = 1
        anim.fromValue = 1.5
        anim.toValue = 1.0
        anim.fillMode = .both
        anim.isRemovedOnCompletion = true
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.layer.add(anim, forKey: nil)
    }
}
