//
//  ProfileCellData.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/29.
//

import Foundation

struct ProfileCellDataModel {
    
    var title: String
    var placeholer: String
    var imageName: String
    
}

struct ProfileCellData {
    
    let list: [ProfileCellDataModel] = [
        ProfileCellDataModel(title: "이름", placeholer: "이름", imageName: ""),
        ProfileCellDataModel(title: "사용자 이름", placeholer: "사용자 이름", imageName: ""),
        ProfileCellDataModel(title: "소개", placeholer: "소개", imageName: ""),
        ProfileCellDataModel(title: "링크", placeholer: "링크", imageName: ""),
        ProfileCellDataModel(title: "성별", placeholer: "성별", imageName: ""),
        ProfileCellDataModel(title: "프로페셔널 계정으로 전환", placeholer: "", imageName: "greaterthan"),
        ProfileCellDataModel(title: "개인정보 설정", placeholer: "", imageName: "greaterthan")
    ]
    
}

