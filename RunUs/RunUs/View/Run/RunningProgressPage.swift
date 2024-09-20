//
//  RunningProgressPage.swift
//  RunUs
//
//  Created by 가은 on 9/11/24.
//

import SwiftUI

struct RunningProgressPage: View {
    @StateObject var mapVM: MapViewModel
    
    var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 15) {
                Text("시간")
                Text("00:00")
                    .font(.title1)
            }
            Divider()
            VStack(spacing: 15) {
                Text("평균 페이스")
                Text("-:--")
                    .font(.title1)
            }
            Divider()
            VStack(spacing: 15) {
                Text("거리")
                Text("0.4km")
                    .font(.title1)
            }
            Button(action: {
                mapVM.stopUpdatingLocation()
            }, label: {
                Image(systemName: "pause.circle")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(.black)
            })
        }
        .font(.body1)
    }
}

#Preview {
    RunningProgressPage(mapVM: MapViewModel())
}
