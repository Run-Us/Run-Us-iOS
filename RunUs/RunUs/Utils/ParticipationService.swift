//
//  ParticipationService.swift
//  RunUs
//
//  Created by byeoungjik on 10/1/24.
//

import Foundation

class ParticipationService: ObservableObject {
    
    let baseUrl = "http://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")"
    @Published var participantInfo: ParticipationResponse?
    
    
}

