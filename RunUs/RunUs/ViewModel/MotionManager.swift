//
//  MotionManager.swift
//  RunUs
//
//  Created by 가은 on 9/21/24.
//

import CoreMotion
import Foundation

class MotionManager: ObservableObject {
    let pedometer = CMPedometer()
    @Published var runningInfo: RunningInfo = RunningInfo()
    
    // 실시간 러닝 정보 업데이트
    func getRealTimeMotionData() {
        
        pedometer.startUpdates(from: Date()) { [weak self] (pedometerData, error) in
            print("start")
            guard let pedometerData = pedometerData, error == nil else {
                print("data is nil")
                return
            }
            
            DispatchQueue.main.async {
                if  let currentPace = pedometerData.currentPace,
                    let distance = pedometerData.distance
                {
                    let minPerKm = Int(currentPace.doubleValue * 1000) / 60
                    let secPerKm = Int(currentPace.doubleValue * 1000) % 60
                    self?.runningInfo.currentPace = "\(minPerKm)\' \(secPerKm)\'\'"
                    self?.runningInfo.distance = distance.intValue
                    
                    let timeInterval = Int(pedometerData.endDate.timeIntervalSince(pedometerData.startDate))
                    self?.runningInfo.runningTime = "\(timeInterval/60):\(timeInterval%60)"
                }
            }
            
        }
    }
    
    // 측정 stop
    func stopRunningMotionData() {
        pedometer.stopUpdates()
    }
    
    // 러닝 데이터 측정 가능 여부 확인
    func checkPedometerAuthorization(completion: @escaping (_ : Bool) -> Void) {
        guard CMPedometer.isDistanceAvailable() || CMPedometer.isPaceAvailable() else {
            print("거리 또는 페이스 측정 불가능")
            completion(false)
            return
        }
        
        completion(true)
    }
}
