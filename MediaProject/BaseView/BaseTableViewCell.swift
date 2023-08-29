//
//  BaseTableViewCell.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/28.
//

import UIKit
import SnapKit
import Kingfisher

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstratints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() { }
    
    func setConstratints() { }
}
