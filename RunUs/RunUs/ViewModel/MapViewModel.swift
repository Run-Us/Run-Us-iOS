//
//  MapViewModel.swift
//  RunUs
//
//  Created by 가은 on 9/11/24.
//

import CoreLocation
import Foundation

class MapViewModel: NSObject, ObservableObject {
    private let locationManager: CLLocationManager
    @Published var userLocation: CLLocation?
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        checkLocationPermission()
        locationManager.startUpdatingLocation()
    }
    
    func checkLocationPermission() {
        switch locationManager.authorizationStatus {
        case .denied:
            print("위치 권한 거부 상태")
        case .notDetermined, .restricted:
            locationManager.requestAlwaysAuthorization()
        default:
            break
        }
        
        // 정확한 위치 설정이 꺼져있는 경우 요청
        switch locationManager.accuracyAuthorization {
        case .reducedAccuracy:
            locationManager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "러닝 기록을 위해 정확한 위치 설정을 켜주세요.")
        default:
            break
        }
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    // 사용자 위치 업데이트
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        userLocation = newLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("error: ", error.localizedDescription)
    }
}
