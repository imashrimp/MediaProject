//
//  ProfileUpperView.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/29.
//

import UIKit

class ProfileUpperView: BaseView {
    
    let photoImageView = MoviePosterCustomImageView(frame: .zero)
    
    let avatarImageView = MoviePosterCustomImageView(frame: .zero)
    
    let profileImageChangeButton = ProfileImageChangeButton(frame: .zero)
    
    override func configure() {
        [
        photoImageView,
        avatarImageView,
        profileImageChangeButton
        ].forEach {
            addSubview($0)
        }
        
        photoImageView.image = UIImage(systemName: "person.fill")
        photoImageView.tintColor = .lightGray
        avatarImageView.image = UIImage(systemName: "person")
        avatarImageView.tintColor = .lightGray

    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(4)
            make.trailing.equalTo(self.snp.centerX).offset(-8)
            make.size.equalTo(80)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(4)
            make.leading.equalTo(self.snp.centerX).offset(8)
            make.size.equalTo(80)
        }
        
        profileImageChangeButton.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(6)
        }
    }
    
    override func layoutSubviews() {
        photoImageView.layer.cornerRadius = 40
        avatarImageView.layer.cornerRadius = 40
    }
}

