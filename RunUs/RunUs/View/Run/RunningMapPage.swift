//
//  RunningMapPage.swift
//  RunUs
//
//  Created by 가은 on 9/10/24.
//

import SwiftUI

struct RunningMapPage: View {
    @StateObject var mapVM: MapViewModel
    
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
                            Button {} label: {
                                Text("끝내기")
                                    .font(.body1)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(width: geometry.size.width*0.35)
                            .background(.black)
                            Button {
                                mapVM.isRunning = true
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
                        Text("00:01")
                    }
                    .frame(width: geometry.size.width/2)
                    VStack(spacing: 15) {
                        Text("평균 페이스")
                            .font(.body1)
                        Text("-:--")
                    }
                    .frame(width: geometry.size.width/2)
                }
                VStack(spacing: 15) {
                    Text("거리")
                        .font(.body1)
                    Text("0.4km")
                }
            }
            .font(.title1)
        }
    }
}

#Preview {
    RunningMapPage(mapVM: MapViewModel())
}
