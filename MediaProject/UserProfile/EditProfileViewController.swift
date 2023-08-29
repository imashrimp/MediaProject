//
//  EditProfileViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/29.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    let mainVC = ProfileTableView()
    
    let profileCellData = ProfileCellData().list
    
    override func loadView() {
        self.view = mainVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mainVC.rowHeight = 70
        mainVC.sectionHeaderHeight = 150
        
        mainVC.delegate = self
        mainVC.dataSource = self
    }
}

extension EditProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ProfileUpperView()
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
}

extension EditProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else { return UITableViewCell() }
        
        let item = profileCellData[indexPath.row]
        
        cell.titleLabel.text = item.title
        cell.userInfoLabel.text = item.placeholer
        cell.rightSideImageView.image = UIImage(systemName: item.imageName)
        
        return cell
    }
    
    
}
