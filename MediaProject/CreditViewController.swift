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
    
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: CreditTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CreditTableViewCell.identifier)
        
        tableView.rowHeight = 100
        
        tableView.delegate = self
        tableView.dataSource = self
        
        uiConfigure()
        showMovieData()
        callRequest()
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
        guard let backgroundPosterUrl = URL(string: backposter) else { return }
        backgroundImage.kf.setImage(with: backgroundPosterUrl)
        
        
    }
    
    func callRequest() {
        guard let id = movieID else { return }
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits"
        
        let header: HTTPHeaders = [ "Authorization" : APIKeys.token]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                
                let data = json["cast"].arrayValue
                let actors = data.filter { $0["known_for_department"].stringValue == "Acting" }
                
                for person in actors {
                    
                    let name = person["name"].stringValue
                    let imageUrl = "https://www.themoviedb.org/t/p/w1280" + person["profile_path"].stringValue
                    let character = person["character"].stringValue
                    
                    let item = CreditData(name: name, image: imageUrl, characterName: character)
                    self.actorlist.append(item)
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension CreditViewController: UITableViewDelegate {
    
}

extension CreditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actorlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier) as! CreditTableViewCell
        
        
        cell.showUIContents(data: actorlist[indexPath.row])
        
        return cell
    }
    
    
}
