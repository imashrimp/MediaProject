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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
                
        }
    }
    
}

extension CreditViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "줄거리"
        case 1:
            return "출연 배우"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return creditList.count
        default:
            return 0
        }
        
//        return creditList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //MARK: - UITableView 하나 더 추가해서 섹션에 automaticdimension 적용된 줄거리 보여주는 셀, 섹션 추가하기
        // 섹션 추가
        // CellView 만들기 => UILabel, Button =>  버튼 누르면 셀 높이가 특정 높이에서 automaticdimesion으로 바뀌고 numberOfLines = 0이 되도록, numberofLines랑 rowHeight 지정하기, => 현재 크레딧 셀에 대해서는 높이가 지정되어있음. 그러면 0번 섹션에 대해서만 높이가 변경되도록 할 수 잇는가? => 할 수 있음 reloadCell 하면 될 듯.
        // 테이블 뷰에 register
        // cellForRowAt 메서드에서 셀 인스턴스 만들고, section = 0 일때, 1일 때 구분해서 셀에 데이터 보여주기
        // 줄거리 셀에 데이터 보여주기(일단, 옵셔널 바인딩 안 하고 보여준 다음 옵셔널로 선언된 프로퍼티에 값을 넣었을 경우 그 값에 'Optional'키워드가 보여지는지 확인하기
                
        if indexPath.section == 0 {
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: MovieOverViewCell.identifier)
                    as? MovieOverViewCell
            else {
                return UITableViewCell()
            }
//            cell.overviewLabel.numberOfLines = 
            cell.overviewLabel.text = movieOverview
            
            return cell
        } else {
            
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: CreditCell.identifier)
                    as? CreditCell
            else {
                return UITableViewCell()
            }
            
            let item = creditList[indexPath.row]
            
            cell.actorNameLabel.text = "배우 이름: \(item.name)"
            
            if let characterName = item.character {
                cell.characterNameLabel.text = "역할: \(characterName)"
            } else {
                cell.characterNameLabel.text = "없음"
            }
            
            guard
                let url = item.profilePath,
                    let imageUrl = URL(string: "https://www.themoviedb.org/t/p/w1280" + url)
            else {
                return UITableViewCell()
            }
            
            cell.actorImageView.kf.setImage(with: imageUrl)

            return cell
        }
    }
}
