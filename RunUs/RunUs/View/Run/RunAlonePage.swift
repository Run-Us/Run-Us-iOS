//
//  RunAlonePage.swift
//  RunUs
//
//  Created by 가은 on 9/18/24.
//

import SwiftUI

enum RunningProgressStatus: String, CaseIterable {
    case text = "진행 상황"
    case map = "지도"
}

struct RunAlonePage: View {
    @StateObject var mapVM: MapViewModel
    @StateObject var runningSessionAlone: RunningSessionService
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                ForEach(RunningProgressStatus.allCases.indices, id: \.self) { index in
                    Text(RunningProgressStatus.allCases[index].rawValue).tag(index)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            TabView(selection: $selectedTab) {
                RunningProgressPage(mapVM: mapVM, motionManager: mapVM.motionManager, selectedTab: $selectedTab)
                    .tag(0)
                RunningMapPage(mapVM: mapVM, motionManager: mapVM.motionManager)
                    .tag(1)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            
            // 권한이 모두 허용됐을 경우에만 측정 시작
            mapVM.motionManager.checkPedometerAuthorization { isSuccess in
                if isSuccess {
                    mapVM.motionManager.runningInfo = RunningInfo(startDate: Date())
                    mapVM.startUpdatingLocation()
                    
                    // Start to connect as webSocket
                    print("Try WebSocket Connect || runningId: \(runningSessionAlone.latestSessionResponse?.payload.runningKey ?? "error")")
                    WebSocketService.shared.connect(runningId: runningSessionAlone.latestSessionResponse?.payload.runningKey ?? "error")
                }
            }
            
        }
    }
}

#Preview {
    RunAlonePage(mapVM: MapViewModel(),runningSessionAlone: RunningSessionService())
}
