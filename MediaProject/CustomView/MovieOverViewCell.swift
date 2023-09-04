//
//  CreditOverViewCell.swift
//  MediaProject
//
//  Created by 권현석 on 2023/09/03.
//

import UIKit

class MovieOverViewCell: BaseTableViewCell {
    
    let overviewLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    let showMoreLabel = {
        let view = UILabel()
        view.text = "더 보기"
        view.textColor = .tintColor
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    override func configure() {
        [
        overviewLabel,
        showMoreLabel
        ].forEach {
            contentView.addSubview($0)
        }
        selectionStyle = .none
        isSelected = false
    }
    
    override func setConstratints() {
        overviewLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(8)
        }
        
        showMoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(55)
            make.top.equalTo(overviewLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview()
        }
    }
    
}
