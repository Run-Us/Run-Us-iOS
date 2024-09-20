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
    @StateObject var mapVM: MapViewModel = MapViewModel()
    @State private var selectedTab: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Picker("", selection: $selectedTab) {
                    ForEach(RunningProgressStatus.allCases.indices, id: \.self) { index in
                        Text(RunningProgressStatus.allCases[index].rawValue).tag(index)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                switch (selectedTab) {
                case 0:
                    RunningProgressPage(mapVM: mapVM)
                        .padding(.top, 50)
                case 1:
                    RunningMapPage(mapVM: mapVM)
                default:
                    EmptyView()
                }
            }
            .navigationBarBackButtonHidden()
        }
        .onAppear {
            mapVM.startUpdatingLocation()
        }
    }
}

#Preview {
    RunAlonePage()
}
