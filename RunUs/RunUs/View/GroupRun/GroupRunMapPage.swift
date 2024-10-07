//
//  RunningGroupMapPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/22/24.
//

import SwiftUI

struct GroupRunMapPage: View {
    @StateObject var mapVM: MapViewModel
    @Binding var showFinishPage: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                RunningMapPage(mapVM: mapVM, motionManager: mapVM.motionManager, showFinishPage: $showFinishPage)
                RunningParticipant()
            }
        }
    }
}
