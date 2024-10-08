//
//  RunningPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/9/24.
//

import SwiftUI

struct RunningPage: View {
    @State var showRunAlonePage = false
    @State var showStartGroupRunPage = false
    @State var passcode: String? = ""
    @ObservedObject var runningSession: RunningSessionService = RunningSessionService()
    @StateObject var mapVM: MapViewModel = .init()
    
    var body: some View {
        ZStack {
            VStack {
                NavigationLink(destination: StartGroupRunPage(runningSession: self.runningSession, mapVM: self.mapVM), label: {
                    Text("같이 달리기")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                
                Button(action: {
                    runningSession.createRunningSession(currentLatitude: mapVM.userLocation.coordinate.latitude, currentLongitude: mapVM.userLocation.coordinate.longitude) { success, result in
                        if success {
                            print("Try WebSocket Connect || runningId: \(result?.payload.runningKey ?? "error")")
                            WebSocketService.sharedSocket.connect(runningSessionInfo: result?.payload)
                            showRunAlonePage = true
                        } else {
                            print("createRunningSession || error")
                        }
                    }
                }, label: {
                    Text("혼자 달리기")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .navigationDestination(isPresented: $showRunAlonePage, destination: {
                    RunAlonePage(mapVM: mapVM, runningSessionAlone: runningSession)
                })
            }
        }
    }
}

#Preview {
    RunningPage()
}
