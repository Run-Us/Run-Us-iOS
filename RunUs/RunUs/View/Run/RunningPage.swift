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
                    
                    // runningType으로 group 러닝일 때 RunningMapPage 재활용
                    switch (selectedTab) {
                    case 0:
                        RunningProgressPage(mapVM: mapVM, motionManager: mapVM.motionManager, selectedTab: $selectedTab)
                    case 1:
                        RunningMapPage(mapVM: mapVM, motionManager: mapVM.motionManager, runningType: .alone, showFinishPage: $showFinishPage)
                    default:
                        RunningMapPage(mapVM: mapVM, motionManager: mapVM.motionManager, runningType: .group, showFinishPage: $showFinishPage)
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    RunningPage(runningType: .group, mapVM: .init())
}
