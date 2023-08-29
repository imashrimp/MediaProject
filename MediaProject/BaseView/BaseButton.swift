//
//  BaseButton.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/29.
//

import UIKit

class BaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() { }
    
    
}
