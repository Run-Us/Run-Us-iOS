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
            VStack(alignment: .center) {
                // Create Group Button
                Image("start_grouprun_image")
                    .padding(36)
                
                Text("친구와 함께 달려보세요!")
                    .font(.title4_semibold)
                    .foregroundStyle(.gray900)
                Text("그룹 달리기를 통해 친구와 같이 기록을 저장하세요")
                    .font(.body2_medium)
                    .foregroundStyle(.gray500)
                
                Spacer()
                Divider()
                    .padding(.vertical, 12)
                // Join Group Button
                Button(action: {
                    showInputJoinCode.toggle()
                }, label: {
                    Text("이미 친구가 방을 만들었나요?")
                        .font(.caption_medium)
                        .underline()
                        .foregroundColor(.gray500)
                })
                // create Group Button
                Button(action: {
                    createGroup()
                }, label: {
                    Text("그룹 생성하기")
                        .font(.title5_bold)
                        .foregroundStyle(.white)
                        .frame(width: 361, height: 56)
                })
                .background(.primary400)
                .cornerRadius(8)
                .padding(8)
                .navigationDestination(isPresented: $showCreateGroupRunPage, destination: {
                    CreateGroupRunPage(mapVM: mapVM, runningSession: runningSession )
                })
                
            }
            
        }
        .alert(Text("그룹 참가하기"), isPresented: $showInputJoinCode, actions: {
            VStack {
                TextField("인증코드", text: $joinCode)
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("취소")
                    })
                    Button(action: {
                        joinGroup()
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
    
    func createGroup() {
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
    }
    func joinGroup() {
        WebSocketService.sharedSocket.connect(runningSessionInfo: nil, passcode: joinCode)
    }
        
}

#Preview {
    StartGroupRunPage(runningSession: RunningSessionService(), mapVM: MapViewModel())
}
