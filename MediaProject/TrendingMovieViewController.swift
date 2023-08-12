//
//  TrendingMovieViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/11.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: - prefetch 또는 데이터 동기 비동기 처리 정하기, rowheight 'dispatchque.main.async'에서 처리, 리팩토링


class TrendingMovieViewController: UIViewController {
    
    var movieList: [TrendingMovie] = []

    @IBOutlet var trendingTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "TrendingTableViewCell", bundle: nil)
        trendingTableView.register(nib, forCellReuseIdentifier: "TrendingTableViewCell")
        
        let cellHeight = UIScreen.main.bounds.height * 0.7
        
        trendingTableView.rowHeight = cellHeight
        
        
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
        
        callRequest()
    }
    
    

    func callRequest() {
        let url = "https://api.themoviedb.org/3/trending/movie/day?language=en-US"
        
        let header: HTTPHeaders = [
            "Authorization": APIKeys.token
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
                
//                print(self.movieList)
                self.trendingTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}


extension TrendingMovieViewController: UITableViewDelegate {
    
    // 선택하면 데이터 넘기고 화면 전환
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("작동하나?")
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreditViewController") as! CreditViewController
        
        vc.movieID = movieList[indexPath.row].id
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension TrendingMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(movieList.count)
        return movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") as! TrendingTableViewCell
        
        
        cell.showCellContents(data: movieList[indexPath.row])
        
        return cell
    }
}

//extension TrendingMovieViewController: UITableViewDataSourcePrefetching {
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        <#code#>
//    }
//}
