//
//  RunningGroupMapPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/22/24.
//

import SwiftUI

struct RunningGroupMapPage: View {
    @StateObject var mapVM: MapViewModel
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                RunningMapPage(mapVM: mapVM, motionManager: mapVM.motionManager)
                RunningParticipant()
            }
        }
    }
}

#Preview {
    RunningGroupMapPage(mapVM: MapViewModel())
}
