//
//  RunningInfo.swift
//  RunUs
//
//  Created by 가은 on 9/21/24.
//

import Foundation

struct RunningInfo {
    var startDate: Date?
    var endDate: Date?
    var runningTime: String?
    var averagePace: String?
    var distance: Double?
}

struct LocationResponse: Codable {
    var success: Bool
    var message: String
    var code: String
    var payload: UserLocation
}

struct Location: Codable {
    var userKey: String
    var x: Double
    var y: Double
}
