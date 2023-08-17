//
//  File.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/15.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String { get }
}

//extension UICollectionViewCell: ReusableProtocol {
//    
//    static var identifier: String {
//        return String(describing: self)
//    }
//}

extension UITableViewCell: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
