//
//  TrendingTableViewCell.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/11.
//

import UIKit
import Kingfisher

class TrendingTableViewCell: UITableViewCell {

    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var originalTitleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var detailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelConfigure(label: releaseDateLabel, textAlignment: .left, fontSize: 13, fontWeight: .regular)
        labelConfigure(label: titleLabel, textAlignment: .left, fontSize: 15, fontWeight: .bold)
        labelConfigure(label: originalTitleLabel, textAlignment: .right, fontSize: 13, fontWeight: .regular)
        labelConfigure(label: detailLabel, textAlignment: .left, fontSize: 13, fontWeight: .regular)
        
        imageViewConfigure(imageView: posterImageView, contentMode: .scaleToFill)
        imageViewConfigure(imageView: detailImageView, contentMode: .scaleAspectFit)
        containerViewConfigure()
        cellConfigure()
    }
    
    func labelConfigure(label: UILabel, textAlignment: NSTextAlignment, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        label.textAlignment = textAlignment
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
    }
    
    func imageViewConfigure(imageView: UIImageView, contentMode: UIView.ContentMode) {
        imageView.contentMode = contentMode
        imageView.tintColor = .black
    }
    
    func containerViewConfigure() {
        containerView.backgroundColor = .clear
    }
    
    func cellConfigure() {
        self.selectionStyle = .none
    }
    
    func showCellContentsDecodable(movie: Result) {
        
    }
}
