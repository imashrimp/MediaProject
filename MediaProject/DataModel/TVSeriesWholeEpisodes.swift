//
//  TVSeriesWholeEpisodes.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/17.
//

import Foundation

//struct Episodes: Codable {
//    let episodes: [EpisodeInfo]
//    let name, overview: String
//    let posterPath: String
//    let seasonNumber: Int
//    let voteAverage: Double
//
//    enum CodingKeys: String, CodingKey {
//        case episodes, name, overview
//        case posterPath = "poster_path"
//        case seasonNumber = "season_number"
//        case voteAverage = "vote_average"
//    }
//}
//
//// MARK: - Episode
//struct EpisodeInfo: Codable {
//    let episodeNumber: Int
//    let id: Int
//    let name: String
//    let runtime, seasonNumber, showID: Int //showID가 드라마 id임
//    let stillPath: String
//
//    enum CodingKeys: String, CodingKey {
//        case episodeNumber = "episode_number"
//        case id, name
//        case runtime
//        case seasonNumber = "season_number"
//        case showID = "show_id"
//        case stillPath = "still_path"
//    }
//}

struct IDK: Codable {
    let episodes: [Episode] //에피소드 디테일
    let name: String // 시즌

    enum CodingKeys: String, CodingKey {
        case episodes, name
    }
}

// MARK: - Episode
struct Episode: Codable {
    let episodeNumber: Int
    let name: String //에피소드 제목
    let seasonNumber: Int //해당 시즌
    let stillPath: String //포스터

    enum CodingKeys: String, CodingKey {
        case episodeNumber = "episode_number"
        case name
        case seasonNumber = "season_number"
        case stillPath = "still_path"
    }
}
