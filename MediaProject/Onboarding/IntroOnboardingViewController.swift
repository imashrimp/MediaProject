//
//  SecondViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/25.
//

import UIKit
import SnapKit

class IntroOnboardingViewController: ViewController {

    let introLabel = {
       let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .white
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 30, weight: .bold)
        view.text = "현재 영화 순위를 확인하고 \n\n줄거리와 등장인물을\n\n확인해보세요."
        return view
    }()
    
    let startButton = {
        let view = UIButton()
        view.setTitle("시작하기", for: .normal)
        view.backgroundColor = .white
        view.setTitleColor(.black, for: .normal)
        view.setTitleColor(.lightGray, for: .highlighted)
        view.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(introLabel)
        introLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(12)
        }
        
        view.addSubview(startButton)
        startButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func doneButtonTapped() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene

        let sceneDelegate = windowScene?.delegate as? SceneDelegate

//        UserDefaults.standard.set(true, forKey: "launched")
        
        let vc = TrendingMovieViewController()

        let nav = UINavigationController(rootViewController: vc)

        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
}
