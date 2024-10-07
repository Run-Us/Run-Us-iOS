//
//  WebSocketService.swift
//  RunUs
//
//  Created by byeoungjik on 9/29/24.
//

import Foundation
import SwiftStomp
import Combine

class WebSocketService: ObservableObject, SwiftStompDelegate {
    static let sharedSocket = WebSocketService(userId: UserDefaults.standard.string(forKey: "userId") ?? "")
    private var swiftStomp: SwiftStomp?
    var runningSessionService: RunningSessionService?
    let WebSocketURL = Bundle.main.object(forInfoDictionaryKey: "WEBSOCKET_URL") as? String
    private var subscriptions = Set<AnyCancellable>()
    var runningSessionInfo: RunningSessionInfo?

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
    func connect(runningSessionInfo: RunningSessionInfo?) {
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
    func sendMessage(body: [String : String], destination: String) {
        let receiptId = "msg-\(Int.random(in: 0..<1000))"
        do {
            let sendData = try JSONEncoder().encode(body)
            swiftStomp?.send(body: sendData, to: destination, receiptId: receiptId, headers: ["Content-Type": "application/json"])
            
        } catch {
            print("Error encoding JSON: \(error)")
            return
        }
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
}

