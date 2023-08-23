//
//  TMDBAPIManager.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/12.
//

import Foundation
import Alamofire
import SwiftyJSON

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    let header: HTTPHeaders = ["Authorization": APIKeys.token]
    
    private init() { }
    
    //MARK: - 상태코드 처리 추가하기
    func callTrendRequest(type: EndPoint, completinHandler: @escaping (TMDB) -> () ) {
        
        let url = type.url
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: TMDB.self, decoder: decoder) { response in
                
                guard let movie = response.value else { return }
                completinHandler(movie)
            }
    }
    
    func callCreditRequest(movieID: Int, completionHandler: @escaping (Credit) -> () ) {
        
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/credits"
        
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: Credit.self) { response in
                guard let credit = response.value else { return }
                completionHandler(credit)
            }
    }
    
    
    
    //MARK: - 도전과제
    func callWholeSeasonRequest(seriesID: Int, completionHandler: @escaping (WholeSeason) -> Void) {
        
        var components = URLComponents(string: "https://api.themoviedb.org/3/tv/\(seriesID)")
        let apiKey = URLQueryItem(name: "api_key", value: APIKeys.key)
        let language = URLQueryItem(name: "language", value: "en-US")
        let apiCategory = URLQueryItem(name: "append_to_response", value: "episode_groups")
        
        components?.queryItems = [apiKey, language, apiCategory]
        
        guard let url = components?.url else { return }
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: WholeSeason.self) { response in
                guard let series = response.value else { return }
                completionHandler(series)
            }
    }
    
    func callWholeEpisodeRequest(seriesID: Int, seasonNm: Int, completionHandler: @escaping (IDK) -> ()) {
                
        let url = "https://api.themoviedb.org/3/tv/\(seriesID)/season/\(seasonNm)?language=en-US"
        
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: IDK.self) { response in
                //MARK: - 에러 핸들링 해보자
                guard let episode = response.value else { return }
                completionHandler(episode)
            }
    }
}
