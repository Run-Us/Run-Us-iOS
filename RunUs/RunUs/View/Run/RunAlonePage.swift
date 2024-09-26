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
    @StateObject var mapVM: MapViewModel = .init()
    @StateObject var motionManager: MotionManager = MotionManager()
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
                RunningProgressPage(mapVM: mapVM, motionManager: motionManager, selectedTab: $selectedTab)
                    .tag(0)
                RunningMapPage(mapVM: mapVM)
                    .tag(1)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            mapVM.startUpdatingLocation()
            motionManager.getRealTimeRunningData()
        }
    }
}

#Preview {
    RunAlonePage()
}
