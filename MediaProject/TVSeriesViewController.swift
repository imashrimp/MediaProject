//
//  TVSeriesViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/17.
//

import UIKit

class TVSeriesViewController: UIViewController {
    
    var seriesInfo: WholeSeason = WholeSeason(genres: [], id: 0, name: "", numberOfEpisodes: 0, numberOfSeasons: 0, seasons: [])
    var episodesArray: [IDK] = []
    
    let firstQueue = DispatchQueue(label: "firstQueue")
    let secondQueue = DispatchQueue(label: "secondQueue")
    
    @IBOutlet var tvSeriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureCollectionViewLayout()
        
        let chulsooGroup = DispatchGroup()
        let yeongheeGroup = DispatchGroup()
        
        chulsooGroup.enter()
        TMDBAPIManager.shared.callWholeSeasonRequest(seriesID: 1395) { series in
            self.seriesInfo = series
            print(self.seriesInfo.numberOfSeasons)
            chulsooGroup.leave()
        }
        
        
        chulsooGroup.notify(queue: .global()) {
            print(self.seriesInfo.numberOfSeasons)
            
            for i in 0..<self.seriesInfo.numberOfSeasons {
                yeongheeGroup.enter()
                //MARK: - notify위치 확인하기 / for문 호출 범위 0, 1확인하기
                
                TMDBAPIManager.shared.callWholeEpisodeRequest(seriesID: self.seriesInfo.id, seasonNm: i) { episodes in
                    self.episodesArray.append(episodes)
                    yeongheeGroup.leave()
                }
            }
            
            yeongheeGroup.notify(queue: .main) {
//                self.tvSeriesCollectionView.reloadData()
            }
        }
    }
}


extension TVSeriesViewController: UICollectionViewDelegate {
    
}

extension TVSeriesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return seriesInfo.numberOfSeasons
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //여기서는 시즌이랑 에피소드 숫자랑 매칭을 해서 조건문에 맞춰 셀 수를 뱉어내자
        
        //섹션이 시즌의 수 만큼 있음. 섹션의 번호에 +1을 하면, 섹션의
        var cnt = 0
        for i in 0..<episodesArray.count {
            if section == i {
                cnt = episodesArray[i].episodes.count
            }
        }
        return cnt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodesCollectionViewCell.identifier, for: indexPath) as? EpisodesCollectionViewCell else { return EpisodesCollectionViewCell() }
  
        //MARK: - 셀의 아이템을 섹션별로 표시할 수 있게 조건문 설정해야함.

//        cell.showContents(data: )
        
        return cell
    }
}

extension TVSeriesViewController: CollectionViewAttributeProtocol {
    func configureCollectionView() {
        tvSeriesCollectionView.delegate = self
        tvSeriesCollectionView.dataSource = self
        let nib = UINib(nibName: EpisodesCollectionViewCell.identifier, bundle: nil)
        tvSeriesCollectionView.register(nib, forCellWithReuseIdentifier: EpisodesCollectionViewCell.identifier)
        
        let headerNib = UINib(nibName: UICollectionReusableView.identifier, bundle: nil)
        tvSeriesCollectionView.register(headerNib, forCellWithReuseIdentifier: UICollectionReusableView.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 250) //이거 UIScreen.main.bounds 이거 써서 수정하자 물론 dispatchque.main.async로 처리
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8 //이거 두개 보고 수정
        layout.scrollDirection = .vertical
        
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        tvSeriesCollectionView.collectionViewLayout = layout
        
    }
    
    
}
