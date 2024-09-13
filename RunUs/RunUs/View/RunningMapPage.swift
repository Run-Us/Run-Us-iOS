//
//  RunningMapPage.swift
//  RunUs
//
//  Created by 가은 on 9/10/24.
//

import SwiftUI

struct RunningMapPage: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                ZStack(alignment: .bottom) {
                    MapPage()
                        .frame(height: geometry.size.width)
                    Button(action: {}, label: {
                        Image(systemName: "pause.circle")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundStyle(.black)
                    })
                    .padding()
                }
                HStack {
                    VStack(spacing: 15) {
                        Text("시간")
                            .font(.body1)
                        Text("00:01")
                    }
                    .frame(width: geometry.size.width/2)
                    VStack(spacing: 15) {
                        Text("평균 페이스")
                            .font(.body1)
                        Text("-:--")
                    }
                    .frame(width: geometry.size.width/2)
                }
                VStack(spacing: 15) {
                    Text("거리")
                        .font(.body1)
                    Text("0.4km")
                }
            }
            .font(.title1)
        }
    }
}

#Preview {
    RunningMapPage()
}
