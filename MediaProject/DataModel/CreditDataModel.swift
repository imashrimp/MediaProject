//
//  CreditDataModel.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/12.
//

import Foundation

struct CreditData {
    var name: String
    var image: String
    var characterName: String
}

// MARK: - Welcome
struct Credit: Codable {
    let id: Int
    let cast: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let knownForDepartment: String //데이터 받아와서 필터링하기 위해 필요함.
    let name: String
    let profilePath: String?
    let character: String?
    
    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case name
        case profilePath = "profile_path"
        case character
    }
}

