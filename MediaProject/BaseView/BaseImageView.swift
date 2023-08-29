//
//  BaseImageView.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/28.
//

import UIKit

class BaseImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() { }
    
}
