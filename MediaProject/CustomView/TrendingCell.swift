//
//  TrendingTableViewCell.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/28.
//

import UIKit

//MARK: - 이름 바꾸기
class TrendingCell: BaseTableViewCell {
    
    let releaseDateLabel = CellLabel(alignment: .left, fontSize: 13, fontWeight: .regular)
    let titleLabel = CellLabel(alignment: .left, fontSize: 15, fontWeight: .bold)
    let originalTitleLabel = CellLabel(alignment: .right, fontSize: 13, fontWeight: .regular)
    let detailLabel = CellLabel(alignment: .left, fontSize: 13, fontWeight: .regular)
    let moviePosterImageView = MoviePosterCustomImageView(frame: .zero)
    let greaterThanImageView = GreaterThanImageView(frame: .zero)
    
    override func configure() {
        [
        releaseDateLabel,
        titleLabel,
        originalTitleLabel,
        detailLabel,
        moviePosterImageView,
        greaterThanImageView
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstratints() {
        releaseDateLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(8)
            make.top.equalTo(contentView).offset(11)
        }
        
        moviePosterImageView.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(moviePosterImageView.snp.width)
        }
        
        titleLabel.setContentHuggingPriority(.init(249), for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(8)
            make.top.equalTo(moviePosterImageView.snp.bottom).offset(8)
        }
        
        originalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(moviePosterImageView.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.trailing).offset(4)
            make.trailing.equalTo(contentView).inset(8)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).inset(11)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        greaterThanImageView.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(detailLabel.snp.trailing).offset(8)
            make.top.equalTo(detailLabel.snp.top)
            make.trailing.equalTo(contentView).inset(8)
            make.bottom.equalTo(detailLabel.snp.bottom)
            make.width.equalTo(greaterThanImageView.snp.height)
        }
    }
    
    func showContents(movie: Result) {
        
        releaseDateLabel.text = movie.releaseDate
        guard let imageUrl = URL(string: "https://www.themoviedb.org/t/p/w1280" + movie.posterPath) else { return }
        moviePosterImageView.kf.setImage(with: imageUrl)
        titleLabel.text = movie.title
        originalTitleLabel.text = movie.originalTitle
        detailLabel.text = "자세히 보기"
        greaterThanImageView.image = UIImage(systemName: "greaterthan")
        
    }
}
