//
//  EpisodesCollectionViewCell.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/17.
//

import UIKit

class EpisodesCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var episodeNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        episodeNumberLabel.font = .systemFont(ofSize: 13)
        episodeNumberLabel.textAlignment = .left
    }

}
