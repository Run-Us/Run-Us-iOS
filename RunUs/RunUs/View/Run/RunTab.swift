//
//  RunTab.swift
//  RunUs
//
//  Created by 가은 on 10/14/24.
//

import SwiftUI

struct RunTab: View {
    @Environment(\.dismiss) var dismiss
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
                    SegmentedPicker(selectedTab: $selectedRunning, type: typeOfRunning, width: geometry.size.width)
                    
                    switch(selectedRunning) {
                    case 0: runAlone()
                    case 1: StartGroupRunPage(runningSession: runningSession, mapVM: mapVM)
                    default: EmptyView()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
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
            .navigationBarBackButtonHidden()
        }
    }
    
    @ViewBuilder
    func runAlone() -> some View {
        ZStack(alignment: .bottom) {
            MapPage(mapVM: mapVM)
                .ignoresSafeArea()
            // 지도 위 흰색 그라데이션 효과
            LinearGradient(colors: [.white.opacity(0.5), .white.opacity(0)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            NavigationLink(destination: RunningPage(runningType: .alone, mapVM: mapVM)) {
                Image("run_start")
                    .buttonStyle(.plain)
                    .offset(y: -15)
            }
            
        }
    }
}

#Preview {
    RunTab()
}

//@State var passcode: String? = ""
//@ObservedObject var runningSession: RunningSessionService = RunningSessionService()
//runningSession.createRunningSession(currentLatitude: mapVM.userLocation.coordinate.latitude, currentLongitude: mapVM.userLocation.coordinate.longitude) { success, result in
//    if success {
//        print("Try WebSocket Connect || runningId: \(result?.payload.runningKey ?? "error")")
//        WebSocketService.sharedSocket.connect(runningSessionInfo: result?.payload)
//        showRunAlonePage = true
//    } else {
//        print("createRunningSession || error")
//    }
//}
