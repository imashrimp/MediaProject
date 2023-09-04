//
//  CreditTableViewCell.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/29.
//

import UIKit

class CreditCell: BaseTableViewCell {
    
    let actorImageView = MoviePosterCustomImageView(frame: .zero)
    
    let actorNameLabel = CellLabel(alignment: .left, fontSize: 15, fontWeight: .bold)
    
    let characterNameLabel = CellLabel(alignment: .left, fontSize: 14, fontWeight: .regular)
    
    
    override func configure() {
        [
            actorImageView,
            actorNameLabel,
            characterNameLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        selectionStyle = .none
    }
    
    override func setConstratints() {
        
        actorImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(11)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(80) //이렇게 안 하고 싶은데....
        }
        
        actorNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(actorImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(actorImageView.snp.centerY).offset(-4)
        }
        
        characterNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(actorImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.top.equalTo(actorImageView.snp.centerY).offset(4)
        }
    }
}
