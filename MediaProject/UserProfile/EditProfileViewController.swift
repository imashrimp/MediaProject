//
//  EditProfileViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/29.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    let mainVC = ProfileTableView()
    
    var profileCellData = ProfileCellData().list
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(showUserName), name: NSNotification.Name("name"), object: nil)
    }
    
    @objc func showUserName(nofitication: NSNotification) {
        
        if let userName = nofitication.userInfo?["name"] as? String {
            profileCellData[0].placeholer = userName
            let index = [IndexPath(row: 0, section: 0), IndexPath(row: 0, section: 1)]
            mainVC.reloadRows(at: index, with: .none)
        }
        
    }
}

extension EditProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ProfileUpperView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditUserInfoViewController()
        
        switch indexPath.row {
        case 0:
            vc.dataPassType = .noti
            vc.titleValue = profileCellData[indexPath.row].title
            
            
            
            
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            vc.dataPassType = .delegate
            vc.titleValue = profileCellData[indexPath.row].title
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            vc.dataPassType = .closure
            vc.titleValue = profileCellData[indexPath.row].title
            navigationController?.pushViewController(vc, animated: true)
        default:
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
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
