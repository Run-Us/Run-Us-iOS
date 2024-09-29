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
    var timer: Timer?
    @Published var runningInfo: RunningInfo = RunningInfo()
    private var secondsElapsed = 0  // 경과한 시간 저장
    
    // 실시간 러닝 정보 업데이트
    func getRealTimeMotionData() {
        
        // Timer를 사용하여 1초마다 업데이트
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            
            // 시간 업데이트
            getRunningTime()
            
            pedometer.startUpdates(from: Date()) { (pedometerData, error) in
                
                guard let pedometerData = pedometerData, error == nil else {
                    print("data is nil")
                    return
                }
                
                // 페이스, 거리 업데이트
                DispatchQueue.main.async {
                    if  let currentPace = pedometerData.currentPace,
                        let distance = pedometerData.distance
                    {
                        let minPerKm = Int(currentPace.doubleValue * 1000) / 60
                        let secPerKm = Int(currentPace.doubleValue * 1000) % 60
                        self.runningInfo.currentPace = "\(minPerKm)\' \(secPerKm)\'\'"
                        self.runningInfo.distance = distance.intValue
                    }
                }
                
            }
        })
        
    }
    
    // 러닝 시간 받아오기
    func getRunningTime() {
        self.secondsElapsed += 1  // 1초 증가
        
        // 초를 분:초 형식으로 변환
        let minutes = self.secondsElapsed / 60
        let seconds = self.secondsElapsed % 60
        self.runningInfo.runningTime = String(format: "%02d:%02d", minutes, seconds)
    }
    
    // 측정 stop
    func stopRunningMotionData() {
        pedometer.stopUpdates()
        stopTimer()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
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
