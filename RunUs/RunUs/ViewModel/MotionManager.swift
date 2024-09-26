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
    func getRealTimeRunningData() {
        
        pedometer.startUpdates(from: Date()) { [weak self] (pedometerData, error) in
            guard let pedometerData = pedometerData, error == nil else {
                print("data is nil")
                return
            }
            
            DispatchQueue.main.async {
                if  let averagePace = pedometerData.averageActivePace,
                    let distance = pedometerData.distance
                {
                    self?.runningInfo.averagePace = (averagePace.doubleValue * 1000) / 60  // 단위를 km로 변환
                    self?.runningInfo.distance = distance.intValue
                }
            }
            
        }
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
