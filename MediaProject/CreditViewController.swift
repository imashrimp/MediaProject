//
//  CreditViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/11.
//

import UIKit

import Alamofire
import Kingfisher
import SnapKit

class CreditViewController: UIViewController {
    
    var movieID: Int?
    var movieTitle: String?
    var movieBackgroundPosterUrl: String?
    var movieOverview: String?
    var creditList: [Cast] = []
    
//    let sectionHeader = OverviewSectionHeader()
    
    let mainVC = CreditCustomView()
    
    
    override func loadView() {
        self.view = mainVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiConfigure()
        callCreditRequest()
    }
    
    func uiConfigure() {
        
        self.navigationController?.navigationBar.tintColor = .black
        
        mainVC.tableView.delegate = self
        mainVC.tableView.dataSource = self
        
        mainVC.tableView.rowHeight = 100
        
        mainVC.movieTitleLabel.text = movieTitle
        guard let url = movieBackgroundPosterUrl, let imageUrl = URL(string: "https://www.themoviedb.org/t/p/w1280" + url) else { return }
        mainVC.moviePosterImage.kf.setImage(with: imageUrl)

    }
    
    func callCreditRequest() {

        guard let id = movieID else { return }

        TMDBAPIManager.shared.callCreditRequest(movieID: id) { credit in
            self.creditList = credit.cast
            self.mainVC.tableView.reloadData()
        }
    }
}

extension CreditViewController: UITableViewDelegate {

}

extension CreditViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(creditList.count)
        return creditList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditCell.identifier) as? CreditCell else { return UITableViewCell()}
        
        let item = creditList[indexPath.row]
        
        cell.actorNameLabel.text = "배우 이름: \(item.name)"
        
        if let characterName = item.character {
            cell.characterNameLabel.text = "역할: \(characterName)"
        } else {
            cell.characterNameLabel.text = "없음"
        }
        
        guard let url = item.profilePath, let imageUrl = URL(string: "https://www.themoviedb.org/t/p/w1280" + url) else { return UITableViewCell() }
        
        cell.actorImageView.kf.setImage(with: imageUrl)

        return cell
    }
}
