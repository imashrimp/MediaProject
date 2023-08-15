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
    
    //    func callRequest(type: EndPoint, completionHandler: @escaping (JSON) -> () ) {
    //
    //        let url = type.url
    //
    //        AF.request(url, method: .get, headers: header).validate()
    //            .responseJSON { response in
    //            switch response.result {
    //            case .success(let value):
    //                let json = JSON(value)
    //
    //                completionHandler(json)
    //
    //
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    //
    //    }
    
    //MARK: - 상태코드 처리 추가하기
    func callRequest(type: EndPoint, completinHandler: @escaping (TMDB) -> () ) {
        
        let url = type.url
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: TMDB.self, decoder: decoder) { response in
                
                guard let movie = response.value else { return }
                completinHandler(movie)
            }
    }
}
