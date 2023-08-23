//
//  CinemaMainViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/23.
//

import UIKit
import SnapKit

class CinemaMainViewController: UIViewController {

    let moveToMapButton = {
        let button = UIButton()
        button.setTitle("영화관 지도 보기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .heavy)
        button.backgroundColor = .brown
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.brown, for: .highlighted)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(moveToMapButton)
        
        moveToMapButton.addTarget(self, action: #selector(moveToMapButtonTapped), for: .touchUpInside)
        
        moveToMapButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }

    }
    
    @objc func moveToMapButtonTapped() {
        let vc = CinemaMapViewController()
        vc.navigationController?.navigationBar.tintColor = .darkGray
        self.navigationController?.pushViewController(vc, animated: true)
    }


}
