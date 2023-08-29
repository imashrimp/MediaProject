//
//  GreaterThanImageView.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/28.
//

import UIKit

class GreaterThanImageView: BaseImageView {
    
    override func configure() {
        contentMode = .scaleAspectFit
        image = UIImage(systemName: "greaterthan")
    }
}
