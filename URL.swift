//
//  URL.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/13.
//

import Foundation

extension URL {
    static let baseUrl = "https://api.themoviedb.org/3"
    
    static func makeEndPointString(_ endPoint: String) -> String {
        return baseUrl + endPoint
    }
}
