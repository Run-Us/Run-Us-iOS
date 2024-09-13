//
//  MapViewModel.swift
//  RunUs
//
//  Created by 가은 on 9/11/24.
//

import CoreLocation
import Foundation

class MapViewModel: ObservableObject {
    let locationManager = CLLocationManager()
    
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
