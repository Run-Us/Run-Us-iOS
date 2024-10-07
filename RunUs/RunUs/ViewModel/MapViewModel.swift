//
//  MapViewModel.swift
//  RunUs
//
//  Created by 가은 on 9/11/24.
//

import CoreLocation
import Foundation
import NMapsMap
import SwiftUI

class MapViewModel: NSObject, ObservableObject {
    private let locationManager: CLLocationManager
    @ObservedObject var motionManager: MotionManager
    @Published var userLocation: CLLocation = CLLocation(latitude: 37.564214, longitude: 127.001699)
    @Published var userPath: [NMGLatLng] = []
    @Published var isRunning: Bool = false
    var count: Int = 0
    
    override init() {
        locationManager = CLLocationManager()
        motionManager = MotionManager()
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
        sendMessageLocationUpdate(currentUserLocation: userLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("error: ", error.localizedDescription)
    }
    
    // 사용자 위치 추적 시작
    func startUpdatingLocation() {
        isRunning = true
        locationManager.startUpdatingLocation()
        motionManager.startUpdatesMotion()
    }
    
    // 사용자 위치 추적 멈춤
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        motionManager.stopRunningMotionData()
    }
    func sendMessageLocationUpdate(currentUserLocation: CLLocation) {
        count += 1
        let runningUpdateInfo = ["runningId": UserDefaults.standard.string(forKey: "runningId") ?? "",
                                 "userId": UserDefaults.standard.string(forKey: "userId") ?? "",
                                 "latitude": String(currentUserLocation.coordinate.latitude),
                                 "longitude": String(currentUserLocation.coordinate.longitude),
                                 "count": String(self.count)] as [String : String]
        print("webSockeet || sendMessage || UPDATELOCATION || \(self.count)|| (\(currentUserLocation.coordinate.latitude), \(currentUserLocation.coordinate.longitude))")
        WebSocketService.sharedSocket.sendMessage(body: runningUpdateInfo, destination: "/app/users/runnings/location")
    }
}
