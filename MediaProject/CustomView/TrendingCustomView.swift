//
//  TrendingCustomView.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/28.
//

import UIKit

class TrendingCustomView: BaseView {
    
    lazy var trendingTableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(TrendingCell.self, forCellReuseIdentifier: TrendingCell.identifier)
        return view
    }()
    
    override func configure() {
        addSubview(trendingTableView)
//        let cellHeight = UIScreen.main.bounds.height * 0.7
//        trendingTableView.rowHeight = 400
//        print(trendingTableView.frame.height)
        trendingTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func setConstraints() {
        trendingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
