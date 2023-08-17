//
//  TVSeriesWholeEpisodes.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/17.
//

import Foundation

struct Episodes: Codable {
    let episodes: [EpisodeInfo]
    let name, overview: String
    let posterPath: String
    let seasonNumber: Int
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case episodes, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}

// MARK: - Episode
struct EpisodeInfo: Codable {
    let episodeNumber: Int
    let id: Int
    let name: String
    let runtime, seasonNumber, showID: Int //showID가 드라마 id임
    let stillPath: String

    enum CodingKeys: String, CodingKey {
        case episodeNumber = "episode_number"
        case id, name
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
    }
}
