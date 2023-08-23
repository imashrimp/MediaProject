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
    var currentAuthorizationStatus: Int32?
    var currentLocation: CLLocationCoordinate2D?
    
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
        button.layer.cornerRadius = 20;
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureVC()
        makeConstraints()
        
        setAnnotation(id: .all)
        checkDeviceLocationAuthorization()
    }
    
    @objc func locationButtonTapped() {
        
        switch currentAuthorizationStatus {
        case 3, 4:
            guard let myCurrentLocation = currentLocation else { return }
            setRegionAndAnnotation(center: myCurrentLocation)
        default:
            locationAuthorizeAlert()
        }
    }
    
    @objc func filterButtonTapped() {
        
        filteringActionSheet { _ in
            self.setAnnotation(id: .lotte)
        } cgv: { _ in
            self.setAnnotation(id: .cgv)
        } megaBox: { _ in
            self.setAnnotation(id: .megabox)
        } all: { _ in
            self.setAnnotation(id: .all)
        }
    }
    
    func setAnnotation(id: CinemaType) {
        mapView.removeAnnotations(mapView.annotations)
        
        let annotationList = filteringCinemaTapped(id: id)
        
        mapView.addAnnotations(annotationList)
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
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                    self.currentAuthorizationStatus = authorization.rawValue
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
            print("authorizedAlways")
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default:
            print("default")
        }
    }
}

extension CinemaMapViewController: CLLocationManagerDelegate {
    
    //사용자 위치 성공적으로 가져올 때마다 호출, kCLLocationAccuracyBest가 판단해서 호출함
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            currentLocation = coordinate
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

//MARK: - ViewControllerConfigure
extension CinemaMapViewController {
    func configureVC() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .darkGray
        
        view.addSubview(mapView)
        view.addSubview(locationButton)
        
        
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        
        locationManager.delegate = self
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
}
