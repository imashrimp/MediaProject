//
//  FiletringCinemaExtension.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/23.
//

import UIKit
import MapKit

extension UIViewController {
    
    //MARK: - 여기서도 분기처리 할 때 열거형 사용해서 메서드 내부에서 let cinemaType: CinemaType의 형태로 사용 가능함
    
    func filteringCinemaTapped(id: CinemaType) -> [MKPointAnnotation] {
        let cinemaList = TheaterList.mapAnnotations
        var annotationList: [MKPointAnnotation] = []
        
        if id == .lotte {
            for cinema in cinemaList {
                if cinema.type == id {
                    let annotation = MKPointAnnotation()
                    annotation.title = cinema.location
                    annotation.coordinate = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
                    annotationList.append(annotation)
                }
            }
            return annotationList
        } else if id == .cgv {
            for cinema in cinemaList {
                if cinema.type == id {
                    let annotation = MKPointAnnotation()
                    annotation.title = cinema.location
                    annotation.coordinate = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
                    annotationList.append(annotation)
                }
            }
            return annotationList
        } else if id == .megabox {
            for cinema in cinemaList {
                if cinema.type == id {
                    let annotation = MKPointAnnotation()
                    annotation.title = cinema.location
                    annotation.coordinate = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
                    annotationList.append(annotation)
                }
            }
            return annotationList
        } else {
            for cinema in cinemaList {
                let annotation = MKPointAnnotation()
                annotation.title = cinema.location
                annotation.coordinate = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
                annotationList.append(annotation)
            }
            return annotationList
        }
    }
}


