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
        
        callSeriesRequest()
        
    }
    
    func callSeriesRequest() {
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
            
            for i in 1...self.seriesInfo.numberOfSeasons {
                yeongheeGroup.enter()
                TMDBAPIManager.shared.callWholeEpisodeRequest(seriesID: self.seriesInfo.id, seasonNm: i) { episodes in
                    self.episodesArray.append(episodes)
                    yeongheeGroup.leave()
                }
            }
            
            yeongheeGroup.notify(queue: .main) {
                self.tvSeriesCollectionView.reloadData()
            }
        }
    }
}


extension TVSeriesViewController: UICollectionViewDelegate {
    
}

//MARK: - ReusableView 추가하면 됨.

extension TVSeriesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return seriesInfo.numberOfSeasons
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

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
        
        for i in 0..<seriesInfo.numberOfSeasons {
            if indexPath.section == i {
                cell.showContents(data: episodesArray[i].episodes[indexPath.row])
            }
        }
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
        let width = UIScreen.main.bounds.width * 0.45
        let height = width * 4/3
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8 //이거 두개 보고 수정
        layout.scrollDirection = .vertical
        
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        tvSeriesCollectionView.collectionViewLayout = layout
    }
}
