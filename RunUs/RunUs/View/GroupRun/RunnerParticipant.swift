//
//  RunnerParticipant.swift
//  RunUs
//
//  Created by byeoungjik on 9/16/24.
//

import SwiftUI

struct RunnerParticipant: View {
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(.pink)
                .frame(width:40, height: 40)
            Text("조성훈")
                .padding()
            Spacer()
            Circle()
                .foregroundColor(.green)
                .frame(width:40, height: 40)
            Text("김현재")
                .padding()
        }
    }
}

#Preview {
    RunnerParticipant()
}
