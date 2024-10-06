//
//  ShareRunningRecordPage.swift
//  RunUs
//
//  Created by 가은 on 10/6/24.
//

import SwiftUI

struct ShareRunningRecordPage: View {
    @StateObject var mapVM: MapViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                HStack {
                    Text("나의 기록을 저장하고, 크루에 공유해보세요!")
                    Spacer()
                }
                
                MapPage(mapVM: mapVM)
            }
            .frame(width: max(geometry.size.width - 20, 0), height: max(geometry.size.width - 20, 0))
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ShareRunningRecordPage(mapVM: .init())
}
