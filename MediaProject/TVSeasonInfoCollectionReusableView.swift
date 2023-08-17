//
//  TVSeasonInfoCollectionReusableView.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/17.
//

import UIKit

class TVSeasonInfoCollectionReusableView: UICollectionReusableView {

    @IBOutlet var seriesTitleLabel: UILabel!
    @IBOutlet var seasonLabel: UILabel!
    @IBOutlet var episodeCountsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        seriesTitleLabel.font = .boldSystemFont(ofSize: 15)
        seriesTitleLabel.textAlignment = .left
        
        seasonLabel.font = .systemFont(ofSize: 13)
        seasonLabel.textAlignment = .left
        
        episodeCountsLabel.font = .systemFont(ofSize: 13)
        episodeCountsLabel.textAlignment = .left
    }
    
}
