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
        print("철수: 일 시작")
        TMDBAPIManager.shared.callWholeSeasonRequest(seriesID: 1395) { series in
            self.seriesInfo = series
            print("철수: 일 끝남")
            chulsooGroup.leave()
        }
        
//MARK: - 리로드 타이밍 잡으려면 영희 디스패치 그룹 써야하는데 어디서 써야함?
        
        chulsooGroup.notify(queue: .main) {
            print("감독: 철수 일 다 끝났답니다")
            for i in 0..<self.seriesInfo.numberOfSeasons {
//                yeongheeGroup.enter()
                print("영희: 일 시작")
                TMDBAPIManager.shared.callWholeEpisodeRequest(seriesID: self.seriesInfo.id, seasonNm: i) { episodes in
                    self.episodesArray.append(episodes)
                    print("=======================")
                    print(self.episodesArray)
                    print("영희: 일 끝남")
//                    yeongheeGroup.leave()
                }
//                yeongheeGroup.notify(queue: .main) {
//                    print("감독: 영희 일 끝났답니다.")
//                    //MARK: - 컬렉션 뷰가 리로드가 되면 맞는거임.
//                    self.tvSeriesCollectionView.reloadData()
//                }
            }
            
        }
    }
//    func callBackNetworking()
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
                print(cnt)
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
