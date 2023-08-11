//
//  TrendingTableViewCell.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/11.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {

    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var detailImageLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func labelConfigure(label: UILabel, textAlignment: NSTextAlignment, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        label.textAlignment = textAlignment
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
    }
    
}
