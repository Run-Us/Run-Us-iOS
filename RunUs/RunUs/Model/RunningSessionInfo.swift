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
    let payload: RunningSessionInfo
}
struct RunningSessionInfo: Codable {
    let runningKey: String
    let passcode: String
}

struct RunningSession: Codable {
    var constraints: RunningSessionConstraints
    var description: RunningSessionDescription
    var startLocation: UserLocation
}

struct RunningSessionConstraints: Codable {
    var maxParticipantCount: Int
    var minPace: Int
}

struct RunningSessionDescription: Codable {
    var title: String
    var desc: String
    var distance: String
    var runningTime: String
}

struct UserLocation: Codable {
    var latitude: Double
    var longitude: Double
}
