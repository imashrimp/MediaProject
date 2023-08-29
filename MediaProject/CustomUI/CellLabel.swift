//
//  Label.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/28.
//

import UIKit

class CellLabel: UILabel {
    
    var alignment: NSTextAlignment
    var fontSize: CGFloat
    var fontWeight: UIFont.Weight
    
    init(alignment: NSTextAlignment, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        self.alignment = alignment
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
