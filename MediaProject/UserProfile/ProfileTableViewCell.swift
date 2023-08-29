//
//  ProfileTableViewCell.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/29.
//

import UIKit

class ProfileTableViewCell: BaseTableViewCell {
    
    let titleLabel = CellLabel(alignment: .left, fontSize: 15, fontWeight: .regular)
    
    let userInfoLabel = CellLabel(alignment: .left, fontSize: 15, fontWeight: .regular)
    
    let rightSideImageView = MoviePosterCustomImageView(frame: .zero)
    
    
    override func configure() {
        [
        titleLabel,
        userInfoLabel,
        rightSideImageView
        ].forEach {
            contentView.addSubview($0)
        }
        
        userInfoLabel.textColor = .lightGray
        rightSideImageView.tintColor = .black
    }
    
    override func setConstratints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(6)
            make.verticalEdges.equalTo(contentView).inset(8)
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
            make.centerY.equalTo(contentView)
            make.height.equalTo(50)
        }
        
        rightSideImageView.snp.makeConstraints { make in
            make.centerY.equalTo(userInfoLabel)
            make.trailing.equalTo(contentView.snp.trailing).inset(8)
            make.leading.greaterThanOrEqualTo(userInfoLabel.snp.trailing).offset(12)
            make.height.equalTo(50)
            make.width.equalTo(30)
        }
    }
}
