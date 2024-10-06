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
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                ZStack(alignment: .bottom) {
                    MapPage(mapVM: mapVM)
                        .frame(height: geometry.size.width)
                    
                    // 일시정지 버튼
                    if mapVM.isRunning {
                        Button(action: {
                            mapVM.stopUpdatingLocation()
                            mapVM.isRunning = false
                        }, label: {
                            Image(systemName: "pause.circle")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundStyle(.black)
                        })
                        .padding()
                    }
                    // 계속하기&끝내기 버튼
                    else {
                        HStack {
                            Spacer()
                            Button {
                                showStopAlert = true
                            } label: {
                                Text("끝내기")
                                    .font(.body1)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(width: geometry.size.width*0.35)
                            .background(.black)
                            .alert("러닝을 종료할까요?", isPresented: $showStopAlert) {
                                HStack {
                                    Button(action: {}, label: {
                                        Text("취소")
                                    })
                                    Button(action: {
                                        // TODO: 러닝 종료
                                        
                                    }, label: {
                                        Text("끝내기")
                                    })
                                }
                            }
                            
                            Button {
                                mapVM.isRunning = true
                                mapVM.startUpdatingLocation()
                            } label: {
                                Text("계속하기")
                                    .font(.body1)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(width: geometry.size.width*0.35)
                            .background(.white)
                        }
                        .frame(height: 70)
                        .padding()
                    }
                }
                HStack {
                    VStack(spacing: 15) {
                        Text("시간")
                            .font(.body1)
                        Text(motionManager.runningInfo.runningTime ?? "00:00")
                    }
                    .frame(width: geometry.size.width/2)
                    VStack(spacing: 15) {
                        Text("평균 페이스")
                            .font(.body1)
                        Text(motionManager.runningInfo.averagePace ?? "-' --''")
                    }
                    .frame(width: geometry.size.width/2)
                }
                VStack(spacing: 15) {
                    Text("거리")
                        .font(.body1)
                    if let distance = motionManager.runningInfo.distance {
                        Text("\(distance, specifier: "%.2f")km")
                    } else {
                        Text("0.00km")
                    }
                }
            }
            .font(.title1)
        }
    }
}

#Preview {
    RunningMapPage(mapVM: MapViewModel(), motionManager: MotionManager())
}
