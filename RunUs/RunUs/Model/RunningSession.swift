//
//  RunningSession.swift
//  RunUs
//
//  Created by byeoungjik on 9/30/24.
//

import Foundation

struct RunningSessionResponse: Codable {
    let success: Bool
    let message: String
    let code: String
    let payload: RunningKey
}
struct RunningKey: Codable {
    let runningKey: String
    let passcode: String
}

struct RunningSession: Codable {
    var constraints: Constraints
    var description: Description
    var startLocation: StartLocation
}

struct Constraints: Codable {
    var maxParticipantCount: Int
    var minPace: Int
}

struct Description: Codable {
    var title: String
    var desc: String
    var distance: String
    var runningTime: String
}

struct StartLocation: Codable {
    var latitude: Double
    var longitude: Double
}
