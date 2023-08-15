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
// 이스케이핑 클로저 공부하고 사용하기


class TrendingMovieViewController: UIViewController {
    
    var movieList: [Result] = []
    
    @IBOutlet var trendingTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TrendingTableViewCell", bundle: nil)
        trendingTableView.register(nib, forCellReuseIdentifier: "TrendingTableViewCell")
        
        //dispatchQueue.main.async해서 다시 적용시키기
        DispatchQueue.main.async {
            let cellHeight = UIScreen.main.bounds.height * 0.7
            
            self.trendingTableView.rowHeight = cellHeight
        }

        trendingTableView.delegate = self
        trendingTableView.dataSource = self
        
        configureSetNav()
        callRequest()
        
    }
    
    
    func callRequest() {
        TMDBAPIManager.shared.callTrendRequest(type: .treding) { movie in
            
            self.movieList = movie.results

            self.trendingTableView.reloadData()
        }
    }
    
    func configureSetNav() {
        self.navigationItem.title = "TMBD Trending Movie of Week"
    }
}


extension TrendingMovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //MARK: - dataSource 해결하고 여기
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreditViewController") as! CreditViewController

        vc.movieID = movieList[indexPath.row].id
        vc.movieTitle = movieList[indexPath.row].title
        vc.movieBackgroundPosterUrl = movieList[indexPath.row].backdropPath

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TrendingMovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") as! TrendingTableViewCell
        
        cell.showCellContentsDecodable(movie: movieList[indexPath.row])
                
        return cell
    }
}
