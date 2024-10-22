//
//  RunningPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/9/24.
//

import SwiftUI

enum RunningType {
    case alone
    case group
}

struct RunningPage: View {
    let runningType: RunningType
    @StateObject var mapVM: MapViewModel
    @State private var selectedTab: Int = 0
    @State private var showFinishPage: Bool = false
    @State private var showStopPopUp: Bool = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // picker
                    SegmentedPicker(
                        selectedTab: $selectedTab,
                        type: runningType == .alone ? ["개요", "지도"] : ["개요", "지도", "그룹원"],
                        width: geometry.size.width
                    )
                    
                    // runningType으로 group 러닝일 때 RunningMapPage 재사용
                    switch (selectedTab) {
                    case 0:
                        RunningProgressPage(
                            mapVM: mapVM,
                            motionManager: mapVM.motionManager,
                            selectedTab: $selectedTab
                        )
                    case 1:
                        RunningMapPage(
                            mapVM: mapVM,
                            motionManager: mapVM.motionManager,
                            runningType: .alone,
                            showStopAlert: $showStopPopUp,
                            selectedTab: $selectedTab,
                            showFinishPage: $showFinishPage
                        )
                    default:
                        RunningMapPage(
                            mapVM: mapVM,
                            motionManager: mapVM.motionManager,
                            runningType: .group,
                            showStopAlert: $showStopPopUp,
                            selectedTab: $selectedTab,
                            showFinishPage: $showFinishPage
                        )
                    }
                }
            }
            .popup(
                isPresented: $showStopPopUp,
                title: "러닝을 종료하시겠어요?",
                subtitle: "시간: \(mapVM.motionManager.runningInfo.runningTime ?? "0:00") / 거리: \(String(format: "%.2fkm", mapVM.motionManager.runningInfo.distance ?? 0.0))",
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
            .navigationBarBackButtonHidden()
            .onAppear {
                
                // 권한이 모두 허용됐을 경우에만 측정 시작
                mapVM.motionManager.checkPedometerAuthorization { isSuccess in
                    if isSuccess {
                        mapVM.motionManager.runningInfo = RunningInfo(startDate: Date())
                        mapVM.startUpdatingLocation()
                    }
                }
                
            }
        }
    }
}

#Preview {
    RunningPage(runningType: .group, mapVM: .init())
}
