//
//  CreditCustomView.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/29.
//

import UIKit

class CreditCustomView: BaseView {
    
    let movieTitleLabel = CellLabel(alignment: .center, fontSize: 25, fontWeight: .regular)
    
    let moviePosterImage = MoviePosterCustomImageView(frame: .zero)
    
    let tableView = {
       let view = UITableView()
        view.register(CreditCell.self, forCellReuseIdentifier: CreditCell.identifier)
        view.register(MovieOverViewCell.self, forCellReuseIdentifier: MovieOverViewCell.identifier)
        return view
    }()
    
    override func configure() {
        backgroundColor = .white
        [
        movieTitleLabel,
        moviePosterImage,
        tableView
        ].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        moviePosterImage.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(moviePosterImage.snp.width).multipliedBy(0.75)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(moviePosterImage.snp.bottom).offset(6)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
