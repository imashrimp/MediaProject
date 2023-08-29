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
import SnapKit

class CreditViewController: UIViewController {
    
    var movieID: Int?
    var movieTitle: String?
    var movieBackgroundPosterUrl: String?
    var movieOverview: String?
    var actorlist: [CreditData] = []
    var creditList: [Cast] = []
    
//    let sectionHeader = OverviewSectionHeader()
//    @IBOutlet var movieTitleLabel: UILabel!
//    @IBOutlet var backgroundImage: UIImageView!
//    @IBOutlet var tableView: UITableView!
    
//    let movieTitleLabel = {
//        let view = UILabel()
//        view.textAlignment = .center
//        view.font = .systemFont(ofSize: 25)
//        view.text = "MOVIE TITLE"
//        return view
//    }()
//
//    let moviePosterImageView = {
//        let view = UIImageView()
//        view.contentMode = .scaleAspectFit
//        view.image = UIImage(systemName: "star")
//        return view
//    }()
//
//    lazy var creditTableView = {
//        let view = UITableView()
//        view.delegate = self
//        view.dataSource = self
//        view.rowHeight = 100
//       return view
//    }()
    
    let mainVC = CreditCustomView()
    
    
    override func loadView() {
        self.view = mainVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print("화면전환 완료")

        
//        view.addSubview(movieTitleLabel)
//        movieTitleLabel.snp.makeConstraints { make in
//            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(8)
//        }
        
//        view.addSubview(moviePosterImageView)
//        moviePosterImageView.snp.makeConstraints { make in
//            make.top.equalTo(movieTitleLabel.snp.bottom).offset(6)
//            make.horizontalEdges.equalToSuperview().inset(8)
//            make.height.equalTo(movieTitleLabel.snp.width).multipliedBy(0.75)
//        }
        
//        view.addSubview(creditTableView)
//        creditTableView.snp.makeConstraints { make in
//            make.top.equalTo(moviePosterImageView.snp.bottom).offset(6)
//            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
//        }
        
//        let nib = UINib(nibName: CreditTableViewCell.identifier, bundle: nil)
        //identifier를 셀 이름으로 받을 수 잇도록 익스텐션에 연산프로퍼티 넣기
//        tableView.register(nib, forCellReuseIdentifier: CreditTableViewCell.identifier)
        
//        tableView.rowHeight = 100
//        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
//        tableView.delegate = self
//        tableView.dataSource = self
        
        uiConfigure()
        
//        creditTableView.register(CreditCell.self, forCellReuseIdentifier: CreditCell.identifier)
        
//        showMovieData()
//        callCreditRequest()
    }
    
    func uiConfigure() {
        
        self.navigationController?.navigationBar.tintColor = .black

    }

    
//    func showMovieData() {
//        guard let title = movieTitle else { return }
//
//        movieTitleLabel.text = title
//
//        guard let backposter = movieBackgroundPosterUrl else { return }
//        guard let backgroundPosterUrl = URL(string: "https://image.tmdb.org/t/p/w1280" + backposter) else { return }
//        backgroundImage.kf.setImage(with: backgroundPosterUrl)
//
//
//    }
    
//    func callCreditRequest() {
//
//        guard let id = movieID else { return }
//
//        TMDBAPIManager.shared.callCreditRequest(movieID: id) { credit in
//            self.creditList = credit.cast
//            self.tableView.reloadData()
//        }
//    }
}

extension CreditViewController: UITableViewDelegate {

}

extension CreditViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        return creditList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //MARK: - 이거 다시 코드 써야함 셀 불러오는게 잘못됨.
//        let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier) as! CreditTableViewCell
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditCell.identifier) as? CreditCell else { return UITableViewCell()}
        
        cell.actorImageView.image = UIImage(systemName: "star")
        cell.actorNameLabel.text = "배우 이름"
        cell.characterNameLabel.text = "역할명"
//        cell.showUIContents(data: creditList[indexPath.row])

        return cell
    }
}
