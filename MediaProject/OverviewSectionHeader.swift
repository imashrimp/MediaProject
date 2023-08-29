//
//  OverviewSectionHeader.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/25.
//

import UIKit
import SnapKit

class OverviewSectionHeader: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(button)
        button.addTarget(CreditViewController(), action: #selector(showDetailButtonTapped), for: .touchUpInside)
        makeConstraints()
    }
    
    @objc func showDetailButtonTapped() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let label = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let button = {
       let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = .white
        return button
    }()
    
    func makeConstraints() {
        label.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(8)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(6)
            make.centerX.equalTo(label)
            make.height.equalTo(30)
            make.width.equalTo(60)
            make.bottom.equalToSuperview().inset(8)
        }
    }
}
