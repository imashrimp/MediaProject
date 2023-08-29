//
//  ProfileTableViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/29.
//

import UIKit

class ProfileTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
        register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        
    }
    
}
