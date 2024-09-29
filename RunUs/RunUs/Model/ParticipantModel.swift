//
//  ParticipantModel.swift
//  RunUs
//
//  Created by byeoungjik on 9/22/24.
//

import Foundation

struct ParticipantModel: Identifiable {
    let id = UUID()
    let name: String
    let distance: Double
    let pace: Double
}
