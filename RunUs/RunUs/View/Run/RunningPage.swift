//
//  RunningPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/9/24.
//

import SwiftUI

struct RunningPage: View {
    @State var showRunAlonePage = false
    @ObservedObject var runningSession: RunningSessionService = RunningSessionService()
    @StateObject var mapVM: MapViewModel = .init()
    var body: some View {
        ZStack {
            VStack {
                NavigationLink(destination: StartGroupRunPage(joinCode: "", runningSession: RunningSessionService()), label: {
                    Text("같이 달리기")
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .cornerRadius(10)
                })
                
                Button(action: {
                    runningSession.createRunningSession(currentLatitude: mapVM.userLocation.coordinate.latitude, currentLongitude: mapVM.userLocation.coordinate.longitude) { success, result in
                        if success {
                            let startRunningInfo = ["userId": UserDefaults.standard.string(forKey: "userId"),
                                                    "runningId": result?.payload.runningKey,
                                                    "runningKey": result?.payload.runningKey]
                            WebSocketService.shared.sendMessage(body: startRunningInfo, destination: "/app/runnings/start")
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
            }
        }
        .navigationDestination(isPresented: $showRunAlonePage, destination: {
            RunAlonePage(mapVM: mapVM, runningSessionAlone: runningSession)
        })
    }
}

#Preview {
    RunningPage()
}
