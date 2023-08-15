//
//  CreditViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/11.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

class CreditViewController: UIViewController {
    
    var movieID: Int?
    var movieTitle: String?
    var movieBackgroundPosterUrl: String?
    var actorlist: [CreditData] = []
    var creditList: [Cast] = []
    
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: CreditTableViewCell.identifier, bundle: nil)
        //identifier를 셀 이름으로 받을 수 잇도록 익스텐션에 연산프로퍼티 넣기
        tableView.register(nib, forCellReuseIdentifier: CreditTableViewCell.identifier)
        
        tableView.rowHeight = 100
        
        tableView.delegate = self
        tableView.dataSource = self
        
        uiConfigure()
        
        showMovieData()
        callCreditRequest()
    }
    
    func uiConfigure() {
        
        self.navigationController?.navigationBar.tintColor = .black
        
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.font = .systemFont(ofSize: 25)
        
        backgroundImage.contentMode = .scaleAspectFit
    }

    
    func showMovieData() {
        guard let title = movieTitle else { return }
        
        movieTitleLabel.text = title
        
        guard let backposter = movieBackgroundPosterUrl else { return }
        guard let backgroundPosterUrl = URL(string: "https://image.tmdb.org/t/p/w1280" + backposter) else { return }
        backgroundImage.kf.setImage(with: backgroundPosterUrl)
        
        
    }
    
    func callCreditRequest() {
        
        guard let id = movieID else { return }
        
        TMDBAPIManager.shared.callCreditRequest(movieID: id) { credit in
            self.creditList = credit.cast
            self.tableView.reloadData()
        }
    }
}

extension CreditViewController: UITableViewDelegate {
    
}

extension CreditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier) as! CreditTableViewCell
        
        
        cell.showUIContents(data: creditList[indexPath.row])
        
        return cell
    }
    
    
}
