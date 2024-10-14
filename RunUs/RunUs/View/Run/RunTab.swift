//
//  RunTab.swift
//  RunUs
//
//  Created by 가은 on 10/14/24.
//

import SwiftUI

struct RunTab: View {
    @StateObject var mapVM: MapViewModel = .init()
    @ObservedObject var runningSession: RunningSessionService = .init()
    @State private var selectedRunning = 0
    let typeOfRunning = ["혼자 달리기", "그룹 달리기"]
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // toolbar와 구분
                    Divider()
                    
                    // Segmented Picker
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            ForEach(0..<typeOfRunning.count, id: \.self) { index in
                                Button {
                                    selectedRunning = index
                                } label: {
                                    Text(typeOfRunning[index])
                                        .frame(maxWidth: .infinity)
                                        .font(.body1_medium)
                                        .foregroundStyle(selectedRunning == index ? .gray900 : .gray400)
                                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 13, trailing: 0))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        
                        // Picket 아래 이동하는 바 (애니메이션 포함)
                        Rectangle()
                            .fill(.primary400)
                            .frame(width: geometry.size.width/CGFloat(typeOfRunning.count), height: 2)
                            .offset(x: geometry.size.width / CGFloat(typeOfRunning.count) * CGFloat(selectedRunning))
                            .animation(.easeOut, value: selectedRunning)
                    }
                    
                    switch(selectedRunning) {
                    case 0: runAlone()
                    case 1: StartGroupRunPage(runningSession: runningSession, mapVM: mapVM)
                    default: EmptyView()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        VStack {
                            Button {
                                
                            } label: {
                                HStack {
                                    Image("back_button")
                                    Text("달리기")
                                        .font(.body1_medium)
                                }
                                .foregroundStyle(.gray900)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func runAlone() -> some View {
        ZStack(alignment: .bottom) {
            MapPage(mapVM: mapVM)
                .ignoresSafeArea()
            // 지도 위 흰색 그라데이션 효과
            LinearGradient(colors: [.white.opacity(0.5), .white.opacity(0)], startPoint: .top, endPoint: .bottom)
            Button {
                
            } label: {
                Image("run_start")
            }
            .buttonStyle(.plain)
            .offset(y: -15)
        }
    }
}

#Preview {
    RunTab()
}
