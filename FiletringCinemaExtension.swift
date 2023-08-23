//
//  FiletringCinemaExtension.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/23.
//

import UIKit
import MapKit

extension UIViewController {
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


