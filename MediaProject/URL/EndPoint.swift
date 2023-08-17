//
//  EndPoint.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/12.
//

import Foundation

enum EndPoint {
    case treding
    //    case credit
    
    var url: String {
        switch self {
        case .treding:
            return URL.makeEndPointString("/trending/movie/day?language=en-US")
            //        case .credit:
            //            return URL.makeEndPointString(<#T##endPoint: String##String#>)
        }
    }
}
