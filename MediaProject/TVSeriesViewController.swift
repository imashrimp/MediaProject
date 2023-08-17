//
//  TVSeriesViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/17.
//

import UIKit

class TVSeriesViewController: UIViewController {

    var seriesInfo: WholeSeason = WholeSeason(genres: [], id: 0, name: "", numberOfEpisodes: 0, numberOfSeasons: 0, seasons: [])
    var episodesArray: [Episodes] = []
    
    let dispatchGroup1 = DispatchGroup()
    let dispatchGroup2 = DispatchGroup()
    let firstQueue = DispatchQueue(label: "firstQueue")
    let secondQueue = DispatchQueue(label: "secondQueue")
    
    @IBOutlet var tvSeriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TMDBAPIManager.shared.callWholeEpisodeRequest(seriesID: 1396, seasonNm: 1) { test in
            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
            print(test)
            
            
        }
        
//        DispatchQueue.main.async {
//            let waitGroup = DispatchGroup()
//            waitGroup.enter()
//            TMDBAPIManager.shared.callWholeSeasonRequest(seriesID: 1396) { series in
//                self.seriesInfo = series
//                waitGroup.leave()
//            }
//            waitGroup.notify(queue: DispatchQueue.main) {
//                for i in 0...self.seriesInfo.numberOfSeasons {
//                    TMDBAPIManager.shared.callWholeEpisodeRequest(seriesID: self.seriesInfo.id, seasonNm: i) { episodes in
//                        print("&&&&&&&&&&&&&&&&&&&&&&&&")
//                        print(episodes)
//                        self.episodesArray.append(episodes)
//                    }
//                }
//            }
//            self.tvSeriesCollectionView.reloadData()
//        }
        
        //시리즈 api데이터를 응답받고 이를 프로퍼티에 할당하는 전체를 하나의 task로 보자
        
//        firstQueue.async(group: dispatchGroup1) {
//            //브레이킹 배드 1396
//            TMDBAPIManager.shared.callWholeSeasonRequest(seriesID: 1396) { series in
//                self.seriesInfo = series
////                self.tvSeriesCollectionView.reloadData()
//            }
//        }
//
//        dispatchGroup1.notify(queue: firstQueue) {
//
//            self.secondQueue.async(group: self.dispatchGroup2) {
//                for i in 0...self.seriesInfo.numberOfSeasons {
//                    TMDBAPIManager.shared.callWholeEpisodeRequest(seriesID: self.seriesInfo.id, seasonNm: i) { episodes in
//                        self.episodesArray.append(episodes)
//                    }
//                }
//            }
//        }
//
//        dispatchGroup2.notify(queue: secondQueue) {
//            self.tvSeriesCollectionView.reloadData()
//        }
    }
}

//func workItem() {
//    let seasonItem =
//}

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
                cnt = episodesArray[i].episodes[i].episodeNumber
                return cnt
            }
        }
        return cnt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodesCollectionViewCell.identifier, for: indexPath) as? EpisodesCollectionViewCell else { return EpisodesCollectionViewCell() }
        
        
        
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
