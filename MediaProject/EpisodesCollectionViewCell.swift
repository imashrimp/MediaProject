//
//  EpisodesCollectionViewCell.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/17.
//

import UIKit
import Kingfisher

class EpisodesCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var episodeNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFit
        
        episodeNumberLabel.font = .systemFont(ofSize: 13)
        episodeNumberLabel.textAlignment = .left
    }
    
    func showContents(data: Episode) {
//        imageView.image =
        episodeNumberLabel.text = "\(data.episodeNumber)"
    }

}
