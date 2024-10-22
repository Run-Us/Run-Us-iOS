//
//  RunningMapPage.swift
//  RunUs
//
//  Created by 가은 on 9/10/24.
//

import SwiftUI

struct RunningMapPage: View {
    @StateObject var mapVM: MapViewModel
    @StateObject var motionManager: MotionManager
    let runningType: RunningType
    @State private var showStopAlert: Bool = false
    @Binding var selectedTab: Int
    @Binding var showFinishPage: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                
                // 상단 지도
                ZStack(alignment: .bottom) {
                    MapPage(mapVM: mapVM)
                        .frame(height: geometry.size.width)
                    
                    // 일시정지 버튼
                    if mapVM.isRunning {
                        Button(action: {
                            mapVM.stopUpdatingLocation()
                            selectedTab = 1
                        }, label: {
                            Image("run_pause")
                                .shadow(radius: 2, x: 0, y: 4)
                        })
                        .padding()
                    }
                    // 계속하기&끝내기 버튼
                    else {
                        HStack(spacing: 40) {
                            Button {
                                showStopAlert = true
                                mapVM.stopUpdatingLocation()
                                WebSocketService.sharedSocket.sendMessageStop()
                            } label: {
                                Image("run_stop")
                                    .shadow(radius: 2, x: 0, y: 4)
                            }
                            
                            Button {
                                mapVM.startUpdatingLocation()
                                WebSocketService.sharedSocket.sendMessageResume()
                            } label: {
                                Image("run_start")
                                    .shadow(radius: 2, x: 0, y: 4)
                            }
                        }
                        .padding()
                    }
                }
                
                // 하단 러닝 정보
                switch (runningType) {
                case .alone: mapTabInfo(width: geometry.size.width/2)
                case .group: RunningParticipant()
                }
            }
            .popup(
                isPresented: $showStopAlert,
                title: "러닝을 종료하시겠어요?",
                subtitle: "시간: \(motionManager.runningInfo.runningTime ?? "0:00") / 거리: \(String(format: "%.2fkm", motionManager.runningInfo.distance ?? 0.0))",
                buttonText: "끝내기",
                buttonColor: .primary400,
                cancelAction: {
                    // 취소 : 다시 위치 측정 시작
                    mapVM.startUpdatingLocation()
                },
                buttonAction: {
                    // 끝내기
                    mapVM.stopUpdatingLocation()
                    WebSocketService.sharedSocket.sendMessageAggregate()
                    showFinishPage = true
            })
            .navigationDestination(isPresented: $showFinishPage) {
                FinishRunningPage(mapVM: mapVM)
            }
        }
    }
    
    @ViewBuilder
    func mapTabInfo(width: CGFloat) -> some View {
        VStack(spacing: 35) {
            HStack {
                Spacer()
                VStack(spacing: 10) {
                    Text(motionManager.runningInfo.runningTime ?? "00:00")
                        .font(.title3_bold)
                        .foregroundStyle(.gray900)
                    Text("시간")
                }
                Spacer()
                VStack(spacing: 10) {
                    Text(motionManager.runningInfo.averagePace ?? "-’--”")
                        .font(.title3_bold)
                        .foregroundStyle(.gray900)
                    Text("평균 페이스")
                }
                Spacer()
            }
            VStack(spacing: 10) {
                if let distance = motionManager.runningInfo.distance {
                    Text("\(distance, specifier: "%.2f")km")
                        .font(.title2_bold)
                        .foregroundStyle(.gray900)
                } else {
                    Text("0.00")
                        .font(.title2_bold)
                        .foregroundStyle(.gray900)
                }
                Text("거리 (km)")
            }
        }
        .font(.body1_medium)
        .foregroundStyle(.gray400)
    }
}

#Preview {
    RunningMapPage(mapVM: MapViewModel(), motionManager: MotionManager(), runningType: .group, selectedTab: .constant(1), showFinishPage: .constant(false))
}
