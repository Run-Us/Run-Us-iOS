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
struct RunGroupPage: View {
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
                RunningProgressPage(mapVM: mapVM, selectedTab: $selectedTab)
                    .tag(0)
                RunningMapPage(mapVM: mapVM)
                    .tag(1)
                RunningGroupMapPage(mapVM: mapVM)
                    .tag(2)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            mapVM.startUpdatingLocation()
        }
    }
}

#Preview {
    RunGroupPage()
}
