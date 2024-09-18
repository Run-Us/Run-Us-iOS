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
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                ForEach(RunningProgressStatus.allCases.indices, id: \.self) { index in
                    Text(RunningProgressStatus.allCases[index].rawValue).tag(index)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding()
    }
}

#Preview {
    RunAlonePage()
}
