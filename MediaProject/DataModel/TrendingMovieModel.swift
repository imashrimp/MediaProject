//
//  TrendingMovieModel.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/11.
//

import Foundation

struct TrendingMovie {
    var id: Int
    var title: String
    var posterImageUrl: String
    var movieBackgroundPoster : String
    var releaseDate: String
    var rate: Double
}

// MARK: - Welcome
struct TMDB: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let backdropPath: String
    let id: Int
    let title: String
    //posterPath를 그대로 쓰면 url로 타입캐스팅을 해도 무용지물임. 그러므로 여기서 값을 추가해줘야함
    let overview, posterPath: String
    let genreIds: [Int]
    let releaseDate: String
    let voteAverage: Double
}

//struct Genre {
//    static let genre: [Int: String] = [
//        28: "Action",
//        12: "Adventure",
//        16: "Animation",
//        35: "Comedy",
//        80: "Crime",
//        99: "Documentary",
//        18: "Drama",
//        10751: "Family",
//        14: "Fantasy",
//        36: "History",
//        27: "Horror",
//        10402: "Music",
//        9648: "Mystery",
//        10749: "Romance",
//        878: "Science Fiction",
//        10770: "TV Movie",
//        53: "Thriller",
//        10752: "War",
//        37: "Western"
//    ]
//}

    //{
    //  "genres": [
    //    {
    //      "id": 28,
    //      "name": "Action"
    //    },
    //    {
    //      "id": 12,
    //      "name": "Adventure"
    //    },
    //    {
    //      "id": 16,
    //      "name": "Animation"
    //    },
    //    {
    //      "id": 35,
    //      "name": "Comedy"
    //    },
    //    {
    //      "id": 80,
    //      "name": "Crime"
    //    },
    //    {
    //      "id": 99,
    //      "name": "Documentary"
    //    },
    //    {
    //      "id": 18,
    //      "name": "Drama"
    //    },
    //    {
    //      "id": 10751,
    //      "name": "Family"
    //    },
    //    {
    //      "id": 14,
    //      "name": "Fantasy"
    //    },
    //    {
    //      "id": 36,
    //      "name": "History"
    //    },
    //    {
    //      "id": 27,
    //      "name": "Horror"
    //    },
    //    {
    //      "id": 10402,
    //      "name": "Music"
    //    },
    //    {
    //      "id": 9648,
    //      "name": "Mystery"
    //    },
    //    {
    //      "id": 10749,
    //      "name": "Romance"
    //    },
    //    {
    //      "id": 878,
    //      "name": "Science Fiction"
    //    },
    //    {
    //      "id": 10770,
    //      "name": "TV Movie"
    //    },
    //    {
    //      "id": 53,
    //      "name": "Thriller"
    //    },
    //    {
    //      "id": 10752,
    //      "name": "War"
    //    },
     //    {
    //      "id": 37,
    //      "name": "Western"
    //    }
    //  ]
    //}
