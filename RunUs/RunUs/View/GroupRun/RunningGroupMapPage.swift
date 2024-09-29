//
//  RunningGroupMapPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/22/24.
//

import SwiftUI

struct RunningGroupMapPage: View {
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
                RunningParticipant()
            }
        }
    }
}

#Preview {
    RunningGroupMapPage(mapVM: MapViewModel())
}
