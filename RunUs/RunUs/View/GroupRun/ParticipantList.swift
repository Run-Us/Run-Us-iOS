//
//  ParticipantList.swift
//  RunUs
//
//  Created by byeoungjik on 9/22/24.
//

import SwiftUI

struct ParticipantList: View {
    let grouprunParticipants = ["김현재", "문다훈", "박지혜", "유가은", "이병직", "조성훈"]
    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        // 그룹런 참가자
        List {
            LazyVGrid(columns: gridLayout, spacing: 20) {
                ForEach(grouprunParticipants, id: \.self) { participant in
                   Participant(participantName: participant)
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    ParticipantList()
}
