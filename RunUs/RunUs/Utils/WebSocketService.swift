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
    private var swiftStomp: SwiftStomp?
    private var subscriptions = Set<AnyCancellable>()
    
    // Published properties to expose to your views or other components
    @Published var isConnected = false
    @Published var messages = [String]()
    @Published var errors = [String]()

    // URL and initialization
    init(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL string.")
            return
        }
        swiftStomp = SwiftStomp(host: url)
        swiftStomp?.delegate = self
        swiftStomp?.autoReconnect = true
    }
    
    // Connect to the WebSocket server
    func connect() {
        swiftStomp?.connect()
    }
    
    // Disconnect from the WebSocket server
    func disconnect() {
        swiftStomp?.disconnect()
        swiftStomp?.disableAutoPing() // Ensure autoPing is disabled on disconnect
    }

    // Subscribe to a topic
    func subscribe(topic: String) {
        swiftStomp?.subscribe(to: topic, mode: .clientIndividual)
    }

    // Send a message to a destination
    func sendMessage(body: String, destination: String) {
        let receiptId = "msg-\(Int.random(in: 0..<1000))"
        swiftStomp?.send(body: body, to: destination, receiptId: receiptId, headers: [:])
    }

    // MARK: - SwiftStompDelegate Methods
    func onConnect(swiftStomp: SwiftStomp, connectType: StompConnectType) {
        isConnected = true
        print("Connected with type: \(connectType)")
        // Subscribe to topics or perform actions after connection is established
        subscribe(topic: "/topic/greetings")
    }

    func onDisconnect(swiftStomp: SwiftStomp, disconnectType: StompDisconnectType) {
        isConnected = false
        print("Disconnected with type: \(disconnectType)")
    }

    func onMessageReceived(swiftStomp: SwiftStomp, message: Any?, messageId: String, destination: String, headers: [String : String]) {
        if let textMessage = message as? String {
            messages.append("\(Date().formatted()) [id: \(messageId), at: \(destination)]: \(textMessage)")
        }
        print("Message received at \(destination): \(message ?? "No content")")
    }

    func onReceipt(swiftStomp: SwiftStomp, receiptId: String) {
        print("Receipt received: \(receiptId)")
    }

    func onError(swiftStomp: SwiftStomp, briefDescription: String, fullDescription: String?, receiptId: String?, type: StompErrorType) {
        errors.append("\(briefDescription), Detailed: \(fullDescription ?? "No details provided")")
        print("Error: \(briefDescription)")
    }
}

