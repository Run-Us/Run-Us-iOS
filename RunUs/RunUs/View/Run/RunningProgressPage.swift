//
//  RunningProgressPage.swift
//  RunUs
//
//  Created by 가은 on 9/11/24.
//

import SwiftUI

struct RunningProgressPage: View {
    @StateObject var mapVM: MapViewModel
    @StateObject var motionManager: MotionManager
    
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 15) {
                Text("시간")
                Text(motionManager.runningInfo.runningTime ?? "00:00")
                    .font(.title1)
            }
            Divider()
            VStack(spacing: 15) {
                Text("평균 페이스")
                Text(motionManager.runningInfo.averagePace ?? "-' --''")
                    .font(.title1)
            }
            Divider()
            VStack(spacing: 15) {
                Text("거리")
                if let distance = motionManager.runningInfo.distance {
                    Text("\(distance, specifier: "%.2f")km")
                        .font(.title1)
                } else {
                    Text("0.00km")
                        .font(.title1)
                }
            }
            Button(action: {
                selectedTab = 1
                mapVM.stopUpdatingLocation()
            }, label: {
                Image(systemName: "pause.circle")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(.black)
            })
        }
        .font(.body1)
    }
}

#Preview {
    RunningProgressPage(mapVM: MapViewModel(), motionManager: MotionManager() ,selectedTab: .constant(0))
}
