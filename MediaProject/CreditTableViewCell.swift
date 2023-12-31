//
//  CreditTableViewCell.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/12.
//

import UIKit

import Kingfisher

class CreditTableViewCell: UITableViewCell {
    
    @IBOutlet var actorImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var characterLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageViewConfigure()
        labelConfigure(label: nameLabel, textColor: .black, fontSize: 15, fontWeight: .bold, textAlignment: .left)
        labelConfigure(label: characterLabel, textColor: .gray, fontSize: 14, fontWeight: .regular, textAlignment: .left)

    }
    
    func showUIContents(data: Cast) {
        
        guard let profileUrl = data.profilePath, let imageUrl = URL(string: "https://image.tmdb.org/t/p/w1280" + profileUrl) else { return }
    
        actorImageView.kf.setImage(with: imageUrl)
        nameLabel.text = data.name
        characterLabel.text = data.character
    }
    
    func imageViewConfigure() {
        actorImageView.contentMode = .scaleAspectFit
        actorImageView.tintColor = .gray
    }
    
    func labelConfigure(label: UILabel, textColor: UIColor, fontSize: CGFloat, fontWeight: UIFont.Weight, textAlignment: NSTextAlignment) {
        label.textColor = textColor
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        label.textAlignment = textAlignment
        
    }
    
}
