//
//  TVSeriesWholeSeason.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/17.
//

import Foundation

// MARK: - Movie
struct WholeSeason: Codable {
    let genres: [Genre] //장르는 name 값만 사용할거임
    let id: Int //아이디로 우선은 검색되게 할 거임. 오늘 수업 예제 처럼 => 현재 드라마 제목 검색으로 나타내려면 너무 복잡함
    let name: String //드라마 제목
    let numberOfEpisodes, numberOfSeasons: Int //총 시즌 수와 에피소드 수 => 시즌 수는 섹션 수를 정할 수 있음.
    let seasons: [Season] //시즌에 대한 정보 배열타입

    enum CodingKeys: String, CodingKey {
        case genres, id
        case name
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case seasons
    }
}


// MARK: - Genre
struct Genre: Codable {
    let name: String
}


//MARK: - id를 사용해서 각 에피소드 정보를 가져올건가?
//WholeSeason의 id와 seasons.seasonNumber를 사용해 한 드라마의 시즌별 에피소드 데이터 가져올 거임.
// MARK: - Season
struct Season: Codable {
    let episodeCount: Int //한 시즌당 에피소드 수
    let id: Int // 아마 이걸로 디테일 뷰에 값 전달 하거나
    let seasonNumber: Int // 몇번째 시즌인지 =>

    enum CodingKeys: String, CodingKey {
        case episodeCount = "episode_count"
        case id
        case seasonNumber = "season_number"
    }
}
