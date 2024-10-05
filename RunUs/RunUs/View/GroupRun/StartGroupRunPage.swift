//
//  StartGroupRunPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/16/24.
//

import SwiftUI

struct StartGroupRunPage: View {
    @State var showInputJoinCode = false
    @State var showJoinGroupRunPage = false
    @State var showCreateGroupRunPage = false
    @State var joinCode: String = ""
    @ObservedObject var runningSession: RunningSessionService
    @StateObject var mapVM: MapViewModel
    var body: some View {
        ZStack {
            VStack {
                // Create Group Button
                Button(action: {
                    runningSession.createRunningSession(currentLatitude: mapVM.userLocation.coordinate.latitude, currentLongitude: mapVM.userLocation.coordinate.longitude) { success, result in
                        if success {
                            print("Try WebSocket Connect || runningId: \(result?.payload.runningKey ?? "error")")
                            UserDefaults.standard.set(result?.payload.runningKey, forKey: "runningId")
                            WebSocketService.sharedSocket.connect(runningSessionInfo: result?.payload)
                            showCreateGroupRunPage = true
                        } else {
                            print("createRunningSession || error")
                        }
                    }
                }, label: {
                    Text("그룹 생성하기")
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .cornerRadius(10)
                })
                .navigationDestination(isPresented: $showCreateGroupRunPage, destination: {
                    CreateGroupRunPage(runningSession: runningSession )
                })
                // Join Group Button
                Button(action: {
                    showInputJoinCode.toggle()
                }, label: {
                    Text("그룹 참가하기")
                        .foregroundColor(.white)
                        .padding()
                })
                .background(.blue)
                .cornerRadius(10)
                
            }
            
        }
        .alert(Text("그룹 참가하기"), isPresented: $showInputJoinCode, actions: {
            VStack {
                TextField("인증코드", text: $joinCode)
                HStack {
                    Button(action: {}, label: {
                        Text("취소")
                    })
                    Button(action: {
                        showJoinGroupRunPage = true
                    }, label: {
                        Text("참가하기")
                    })
                }
            }
        }, message: {
            Text("생성된 대기방의 인증코드를 입력해주세요")
        })
        .navigationDestination(isPresented: $showJoinGroupRunPage, destination: {
            JoinGroupRunPage(RunningSession: runningSession)
        })

    }
        
}

#Preview {
    StartGroupRunPage(runningSession: RunningSessionService(), mapVM: MapViewModel())
}
