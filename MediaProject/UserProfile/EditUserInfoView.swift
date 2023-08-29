//
//  EditUserInfoView.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/29.
//

import UIKit

class EditUserInfoView: BaseView {
    
    let label = CellLabel(alignment: .left, fontSize: 13, fontWeight: .regular)
    
    let textField = UITextField()
    
    override func configure() {
        addSubview(label)
        addSubview(textField)
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(4)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
    }
}
