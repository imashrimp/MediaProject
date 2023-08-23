//
//  CinemaMapViewController.swift
//  MediaProject
//
//  Created by 권현석 on 2023/08/23.
//

import UIKit
import CoreLocation
import MapKit

import SnapKit

class CinemaMapViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    let mapView = MKMapView()
    
    let filterButton = {
        let button = UIButton()
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        return button
    }()
    
    let locationButton = {
        let button = UIButton()
        let imageSize = UIImage.SymbolConfiguration(pointSize: 30)
        let image = UIImage(systemName: "location.fill", withConfiguration: imageSize)
        button.backgroundColor = .white
        button.setImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        //        button.tintColor = .
        button.layer.cornerRadius = 20;
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        view.addSubview(locationButton)
        makeConstraints()
        
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        
        locationManager.delegate = self
        
        setAnnotation(id: .all)
        
        checkDeviceLocationAuthorization()
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .darkGray
    }
    
    //MARK: - 매개변수 사용해서 분기처리하기
    func setAnnotation(id: CinemaType) {
        
        let cinemaList = TheaterList().mapAnnotations
        var annotationList: [MKPointAnnotation] = []
        mapView.removeAnnotations(mapView.annotations)
        
        if id == .lotte {
            for cinema in cinemaList {
                if cinema.type == id {
                    let annotation = MKPointAnnotation()
                    annotation.title = cinema.location
                    annotation.coordinate = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
                    annotationList.append(annotation)
                }
            }
        } else if id == .cgv {
            for cinema in cinemaList {
                if cinema.type == id {
                    let annotation = MKPointAnnotation()
                    annotation.title = cinema.location
                    annotation.coordinate = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
                    annotationList.append(annotation)
                }
            }
        } else if id == .megabox {
            for cinema in cinemaList {
                if cinema.type == id {
                    let annotation = MKPointAnnotation()
                    annotation.title = cinema.location
                    annotation.coordinate = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
                    annotationList.append(annotation)
                }
            }
        } else {
            for cinema in cinemaList {
                let annotation = MKPointAnnotation()
                annotation.title = cinema.location
                annotation.coordinate = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
                annotationList.append(annotation)
            }
        }
        mapView.addAnnotations(annotationList)
    }
    
    //MARK: - 권한 있을 때랑 없을 때랑 다르게 분기처리를 해보자
    @objc func locationButtonTapped() {
        let alert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            
            guard let appSetting = URL(string: UIApplication.openSettingsURLString) else {
                print("설정 URL 잘 못 가져왔음.")
                return
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @objc func filterButtonTapped() {
        print("필터링 할 액션시트 나와라")
        
        let filterActionsheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        let lotteCinema = UIAlertAction(title: "롯데시네마", style: .default) {_ in
            self.setAnnotation(id: .lotte)
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) {_ in
            self.setAnnotation(id: .cgv)
        }
        let megaBox = UIAlertAction(title: "메가박스", style: .default) {_ in
            self.setAnnotation(id: .megabox)
        }
        let showAll = UIAlertAction(title: "전체보기", style: .default) {_ in
            self.setAnnotation(id: .all)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        filterActionsheet.addAction(lotteCinema)
        filterActionsheet.addAction(cgv)
        filterActionsheet.addAction(megaBox)
        filterActionsheet.addAction(showAll)
        filterActionsheet.addAction(cancel)
        
        present(filterActionsheet, animated: true)
    }
    
    func makeConstraints() {
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        locationButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.leading.equalTo(mapView.snp.leading).offset(20)
            make.bottom.equalTo(mapView.snp.bottom).inset(40)
        }
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "내 위치"
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
    }
}

extension CinemaMapViewController: CLLocationManagerDelegate {
    
    //사용자 위치 성공적으로 가져올 때마다 호출, kCLLocationAccuracyBest가 판단해서 호출함
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            //이게 현재 위치를 디바이스 위치로 설정
            setRegionAndAnnotation(center: coordinate)
        }
        locationManager.stopUpdatingLocation()
    }
    
    //사용자 위치정보 가져오는데 실패한 경우 호출
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        setRegionAndAnnotation(center: center)
    }
    
    //권한 상태가 바뀔 때 호출됨 (허용->거부 OR 거부->허용 OR 초기설정)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
    //iOS 14이전 버전에서 사용됨
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
}

//MARK: - Location Authorization
extension CinemaMapViewController {
    func checkDeviceLocationAuthorization() {
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    //MARK: - 14.0 아래의 버전에서는 무슨 권한의 어떤 상태를 가져온다는 거지?
                    authorization = CLLocationManager.authorizationStatus()
                }
                print(authorization)
                //MARK: - 이거를 왜 dispatch queue.main.async에서 해야하는거지?
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
            } else {
                print("위치 서비스가 꺼져있어서 위치 권한 요청을 할 수 없습니다.")
            }
        }
        
    }
    
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
            locationManager.startUpdatingLocation()
        case .authorizedAlways:
            //MARK: - 여기서도 위치 업데이트 해줘야하는거 아닌가? whenInUse에서만 업데이트 하면 여기도 처리가 알아서 되는건지 찾아보자
            print("authorizedAlways")
        case .authorizedWhenInUse:
            //MARK: - 아래의 메서드가 딜리게이트의 didUpdate 메서드를 호출하는지 확인
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default:
            print("default")
        }
    }
}
