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
                    
                    switch (selectedTab) {
                    case 0:
                        RunningProgressPage(mapVM: mapVM, motionManager: mapVM.motionManager, selectedTab: $selectedTab)
                    case 1:
                        RunningMapPage(mapVM: mapVM, motionManager: mapVM.motionManager, showFinishPage: $showFinishPage)
                    default:
                        EmptyView()
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
