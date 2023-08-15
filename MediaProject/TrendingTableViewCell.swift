//
//  TrendingTableViewCell.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/11.
//

import UIKit
import Kingfisher

class TrendingTableViewCell: UITableViewCell {
    
    static let identifier = "TrendingTableViewCell"

    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var detailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelConfigure(label: releaseDateLabel, textAlignment: .left, fontSize: 13, fontWeight: .regular)
        labelConfigure(label: titleLabel, textAlignment: .left, fontSize: 15, fontWeight: .bold)
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
    }
    
    func containerViewConfigure() {
        containerView.backgroundColor = .clear
    }
    
    func cellConfigure() {
        self.selectionStyle = .none
    }
    
//    func showCellContents(data: TrendingMovie) {
//        releaseDateLabel.text = data.releaseDate
//        guard let imageUrl = URL(string: data.posterImageUrl) else { return }
//        posterImageView.kf.setImage(with: imageUrl)
//        titleLabel.text = data.title
//        detailLabel.text = "자세히 보기"
//        detailImageView.image = UIImage(systemName: "greaterthan")
//    }
    
    func showCellContentsDecodable(movie: Result) {
        releaseDateLabel.text = movie.releaseDate
        guard let imageUrl = URL(string: "https://www.themoviedb.org/t/p/w1280" + movie.posterPath) else { return }
        posterImageView.kf.setImage(with: imageUrl)
        titleLabel.text = movie.title
        detailLabel.text = "자세히 보기"
        detailImageView.image = UIImage(systemName: "greaterthan")
    }
    
}
