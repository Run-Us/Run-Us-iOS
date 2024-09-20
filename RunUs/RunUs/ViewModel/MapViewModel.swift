//
//  MapViewModel.swift
//  RunUs
//
//  Created by 가은 on 9/11/24.
//

import CoreLocation
import Foundation
import NMapsMap

class MapViewModel: NSObject, ObservableObject {
    private let locationManager: CLLocationManager
    @Published var userLocation: CLLocation?
    @Published var userPath: [NMGLatLng] = []
    @Published var isRunning: Bool = false
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        checkLocationPermission()
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
        userPath.append(NMGLatLng(from: newLocation.coordinate))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("error: ", error.localizedDescription)
    }
    
    // 사용자 위치 추적 시작
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    // 사용자 위치 추적 멈춤
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}
