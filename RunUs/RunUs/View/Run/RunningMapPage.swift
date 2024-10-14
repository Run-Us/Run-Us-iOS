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
    @State private var showStopAlert: Bool = false
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
                        }, label: {
                            Image("run_pause")
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
                            }
                            .alert("러닝을 종료할까요?", isPresented: $showStopAlert) {
                                HStack {
                                    Button(action: {
                                        mapVM.startUpdatingLocation()
                                    }, label: {
                                        Text("취소")
                                    })
                                    Button(action: {
                                        mapVM.stopUpdatingLocation()
                                        WebSocketService.sharedSocket.sendMessageAggregate()
                                        showFinishPage = true
                                    }, label: {
                                        Text("끝내기")
                                    })
                                }
                            }
                            
                            Button {
                                mapVM.startUpdatingLocation()
                                WebSocketService.sharedSocket.sendMessageResume()
                            } label: {
                                Image("run_start")
                            }
                        }
                        .padding()
                    }
                }
                
                // 하단 러닝 정보
                mapTabInfo(width: geometry.size.width/2)
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
                    Text(motionManager.runningInfo.averagePace ?? "-'--''")
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
    RunningMapPage(mapVM: MapViewModel(), motionManager: MotionManager(), showFinishPage: .constant(false))
}
