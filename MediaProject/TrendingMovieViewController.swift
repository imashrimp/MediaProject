//
//  TrendingMovieViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/11.
//

import UIKit
import Alamofire

//MARK: - BASEVC 만들어야하나?
class TrendingMovieViewController: UIViewController {
    
    var movieList: [Result] = []
    
    let trendCustomView = TrendingCustomView()
    
    override func loadView() {
        self.view = trendCustomView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendCustomView.trendingTableView.delegate = self
        trendCustomView.trendingTableView.dataSource = self
        trendCustomView.trendingTableView.rowHeight = UITableView.automaticDimension
        
        setNav()
        callRequest()
        
    }
    
    @objc func editProfileButtonTapped() {
        let vc = EditProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func callRequest() {
        TMDBAPIManager.shared.callTrendRequest(type: .treding) { movie in
            dump(movie)
            self.movieList = movie.results
            
            self.trendCustomView.trendingTableView.reloadData()
        }
    }
    
    func setNav() {
        self.navigationItem.title = "주간 인기 영화"
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "프로필 편집", style: .plain, target: self, action: #selector(editProfileButtonTapped))
    }
}


extension TrendingMovieViewController: UITableViewDelegate {
    
    //MARK: - 여기 수정해야함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = CreditViewController()
        
        let item = movieList[indexPath.row]
        
        vc.movieID = item.id
        vc.movieTitle = item.title
        vc.movieBackgroundPosterUrl = item.backdropPath
        vc.movieOverview = item.overview
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension TrendingMovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCell.identifier) as? TrendingCell else { return UITableViewCell() }
        
        cell.showContents(movie: movieList[indexPath.row])
        
        return cell
    }
}
