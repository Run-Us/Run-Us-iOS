//
//  WebSocketService.swift
//  RunUs
//
//  Created by byeoungjik on 9/29/24.
//

import Foundation
import SwiftStomp
import Combine
import CoreLocation

class WebSocketService: ObservableObject, SwiftStompDelegate {
    static let sharedSocket = WebSocketService(userId: UserDefaults.standard.string(forKey: "userId") ?? "")
    private var swiftStomp: SwiftStomp?
    var runningSessionService: RunningSessionService?
    let WebSocketURL = Bundle.main.object(forInfoDictionaryKey: "WEBSOCKET_URL") as? String
    private var subscriptions = Set<AnyCancellable>()
    var runningSessionInfo: RunningSessionInfo?
    var count: Int = 0
    
    // Published properties to expose to your views or other components
    @Published var isConnected = false
    @Published var messages = [String]()
    @Published var errors = [String]()
    
    // URL and initialization
    init(userId: String, passcode: String = "") {
        guard let url = URL(string: "ws://" + WebSocketURL!) else {
            print("Invalid URL string.")
            return
        }
        let headers = [
            "accept-version": "1.2,1.1,1.0",
            "heart-beat": "10000,10000",
            "passcode": passcode,
            "user-id": userId
        ]
        swiftStomp = SwiftStomp(host: url, headers: headers)
        swiftStomp?.delegate = self
        swiftStomp?.autoReconnect = true
        print("\(userId) : webSocket instance is created")
    }
    
    // Connect to the WebSocket server
    func connect(runningSessionInfo: RunningSessionInfo?, passcode: String = "") {
        self.runningSessionInfo = runningSessionInfo
        swiftStomp?.connect(acceptVersion: "1.2,1.1,1.0")
    }
    
    // Disconnect from the WebSocket server
    func disconnect() {
        swiftStomp?.disconnect()
        swiftStomp?.disableAutoPing() // Ensure autoPing is disabled on disconnect
    }
    
    // Subscribe to a topic
    func subscribe(topic: String) {
        guard let id = UserDefaults.standard.string(forKey: "userId") else {
            print("invalid userId")
            return
        }
        let subscribeHeader:[String: String] = [
            "id": id
        ]
        swiftStomp?.subscribe(to: topic, mode: .clientIndividual, headers: subscribeHeader)
    }
    
    // Send a message to a destination
    func sendMessage(body: [String : String?], destination: String) {
        let receiptId = "msg-\(Int.random(in: 0..<1000))"
        swiftStomp?.send(body: body, to: destination, receiptId: receiptId, headers: ["Content-Type": "application/json"])
    }
    
    // MARK: - SwiftStompDelegate Methods
    func onConnect(swiftStomp: SwiftStomp, connectType: StompConnectType) {
        print("Connected with type: \(connectType)")
        
        // Subscribe to topics or perform actions after connection is established
        
        if connectType == .toStomp {
            print("Connection is fully established with STOMP protocol.")
            isConnected = true
            
            if let runningId = runningSessionInfo?.runningKey {
                subscribe(topic: "/topic/runnings/\(runningId)")
                print("subscribe is started.. || runningId: \(runningId)")
            }
        }
    }
    
    func onDisconnect(swiftStomp: SwiftStomp, disconnectType: StompDisconnectType) {
        isConnected = false
        print("Disconnected with type: \(disconnectType)")
    }
    
    func onMessageReceived(swiftStomp: SwiftStomp, message: Any?, messageId: String, destination: String, headers: [String : String]) {
        guard let messageData = message as? String else {
            print("Received non-string message")
            return
        }
        
        guard let jsonData = messageData.data(using: .utf8) else {
            print("Error: Cannot create Data from messageData")
            return
        }
        
        do {
            let decodedMessage = try JSONDecoder().decode(LocationResponse.self, from: jsonData)
            messages.append("\(decodedMessage.code) [id: \(messageId), at: \(destination)]: \(decodedMessage.message)")
            print("Message received at \(destination): \(decodedMessage.message)")
        } catch {
            print("Decoding error: \(error)")
        }
    }
    
    func onReceipt(swiftStomp: SwiftStomp, receiptId: String) {
        print("Receipt received: \(receiptId)")
    }
    
    func onError(swiftStomp: SwiftStomp, briefDescription: String, fullDescription: String?, receiptId: String?, type: StompErrorType) {
        errors.append("\(briefDescription), Detailed: \(fullDescription ?? "No details provided")")
        print("Error: \(briefDescription)")
    }
    
    func sendMessageLocationUpdate(currentUserLocation: CLLocation) {
        let receiptId = "msg-\(Int.random(in: 0..<1000))"
        count += 1
        let runningUpdateInfo = RunningUpdateInfo (
            runningId: UserDefaults.standard.string(forKey: "runningId") ?? "",
            userId: UserDefaults.standard.string(forKey: "userId") ?? "",
            latitude: currentUserLocation.coordinate.latitude,
            longitude: currentUserLocation.coordinate.longitude,
            count: self.count)
        print("\(self.count) : webSockeet || sendMessage || UPDATELOCATION || \(receiptId)|| (\(currentUserLocation.coordinate.latitude), \(currentUserLocation.coordinate.longitude))")
        
            self.swiftStomp?.send(body: runningUpdateInfo, to: "/app/users/runnings/location", receiptId: receiptId, headers: ["content-type": "application/json"])
    }
    
    func sendMessagePause() {
        let pauseInfo = [
            "userId": UserDefaults.standard.string(forKey: "userId"),
            "runningId": runningSessionInfo?.runningKey
        ]
        WebSocketService.sharedSocket.sendMessage(body: pauseInfo, destination: "/app/users/runnings/pause")
    }
    
    func sendMessageStop() {
        let stopInfo = [
            "userId": UserDefaults.standard.string(forKey: "userId"),
            "runningId": runningSessionInfo?.runningKey
        ]
        WebSocketService.sharedSocket.sendMessage(body: stopInfo, destination: "/app/hello")
    }
}

