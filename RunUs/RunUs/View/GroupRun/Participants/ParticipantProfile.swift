//
//  RunnerParticipant.swift
//  RunUs
//
//  Created by byeoungjik on 9/16/24.
//

import SwiftUI

struct ParticipantProfile: View {
    let participantName: String
    let participantColor: Color = Color.random
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(participantColor)
                .frame(width:40, height: 40)
            Text(participantName)
                .padding()
                
        }
    }
}

extension Color {
    static var random: Color {
        return Color (
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

#Preview {
    ParticipantProfile(participantName: "참가자 이름")
}
