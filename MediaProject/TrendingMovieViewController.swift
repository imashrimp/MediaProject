//
//  TrendingMovieViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/11.
//

import UIKit
import Alamofire
import SwiftyJSON

class TrendingMovieViewController: UIViewController {
    
    var movieList: [TrendingMovie] = []

    @IBOutlet var trendingTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        let nib = UINib(nibName: "TrendingTableViewCell", bundle: nil)
        trendingTableView.register(nib, forCellReuseIdentifier: "TrendingTableViewCell")
        
        trendingTableView.rowHeight = 600
        
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
        
        callRequest()
    }
    
    

    func callRequest() {
        let url = "https://api.themoviedb.org/3/trending/movie/day?language=en-US"
        
        let header: HTTPHeaders = [
            "Authorization": APIKeys.treding
        ]
        
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let dataList = json["results"].arrayValue
                
                for data in dataList {
                    let id = data["id"].intValue
                    let title = data["title"].stringValue
                    let posterUrl = "https://www.themoviedb.org/t/p/w1280/" + data["poster_path"].stringValue
                    let releaseDate = data["release_date"].stringValue
                    let rate = data["vote_average"].doubleValue
                    
                    let movie = TrendingMovie(id: id, title: title, posterImageUrl: posterUrl, releaseDate: releaseDate, rate: rate)
                    
                    self.movieList.append(movie)
                }
                
                print(self.movieList)
                self.trendingTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}


extension TrendingMovieViewController: UITableViewDelegate {

}

extension TrendingMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movieList.count)
        return movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") as! TrendingTableViewCell
        
        
        cell.showCellContents(data: movieList[indexPath.row])
        
        return cell
    }


}
