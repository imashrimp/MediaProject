//
//  CustomButton.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/29.
//

import UIKit

class ProfileImageChangeButton: BaseButton {
    
    override func configure() {
        var config = UIButton.Configuration.plain()
        config.title = "사진 또는 아바타 변경"
        config.baseForegroundColor = .tintColor
        
        self.configuration = config
    }
}
