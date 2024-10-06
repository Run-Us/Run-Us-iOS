//
//  Run.swift
//  RunUs
//
//  Created by byeoungjik on 9/22/24.
//

import SwiftUI

enum RunningGroupProgressStatus: String, CaseIterable {
    case text = "진행 상황"
    case map = "지도"
    case group = "그룹원"
}
struct GroupRunPage: View {
    @StateObject var mapVM: MapViewModel = .init()
    @State private var selectedTab: Int = 0
    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                ForEach(RunningGroupProgressStatus.allCases.indices, id: \.self) { index in
                    Text(RunningGroupProgressStatus.allCases[index].rawValue).tag(index)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            TabView(selection: $selectedTab) {
                RunningProgressPage(mapVM: mapVM, motionManager: mapVM.motionManager, selectedTab: $selectedTab)
                    .tag(0)
                RunningMapPage(mapVM: mapVM, motionManager: mapVM.motionManager)
                    .tag(1)
                GroupRunMapPage(mapVM: mapVM)
                    .tag(2)
            }
        }
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

#Preview {
    GroupRunPage()
}
