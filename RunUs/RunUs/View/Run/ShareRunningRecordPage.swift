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
        VStack {
            Text("나의 기록을 저장하고, 크루에 공유해보세요!")
            
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ShareRunningRecordPage(mapVM: .init())
}
