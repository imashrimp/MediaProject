//
//  TMDBAPIManager.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/12.
//

import Foundation
import Alamofire
//import SwiftyJSON

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
}
