//
//  CreditViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/11.
//

import UIKit
import SwiftyJSON
import Alamofire

class CreditViewController: UIViewController {
    
    var movieID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

       callRequest()
    }

    //MARK: - 이거 호출 데이터 필터링하자
    func callRequest() {
        guard let id = movieID else { return }
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits"
        
        let header: HTTPHeaders = [ "Authorization" : APIKeys.token]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
}
