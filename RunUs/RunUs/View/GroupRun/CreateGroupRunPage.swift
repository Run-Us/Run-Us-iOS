//
//  CreateGroupRunPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/16/24.
//

import SwiftUI

struct CreateGroupRunPage: View {
    @Binding var noticeContent: String?
    @State var noticeBar = NoticeBar(noticeContent: .constant("러너에게 아래 인증번호를 알려주세요"))
    @State var showStartGroupRunAlter = false
    @StateObject private var webSocketService = WebSocketService(userId: UserDefaults.standard.string(forKey: "userId") ?? "", passcode: "")
    @ObservedObject var runningSession: RunningSessionService
    @State var startGroupRun = false
    @StateObject var participationService = ParticipationService()
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        // 알림창
                        noticeBar
                            .frame(width: geometry.size.width)
                        VStack {
                            // 인증번호
                            Text("인증번호")
                            Text( runningSession.latestSessionResponse?.payload.passcode ?? "error")
                                .font(.system(size: 82, weight: .bold))
                            if participationService.participantNames.isEmpty {
                                Text("참가자 목록을 불러오는 중...")
                                    .onAppear {
                                        participationService.getParticipantList { success in
                                            if !success {
                                                print("참가자 정보 불러오기 실패")
                                            }
                                        }
                                    }
                            } else {
                                ParticipantList(grouprunParticipants: participationService.participantNames)
                            }
                            
                        }
                        .padding(.vertical)
                        
                    }
                }
                .onAppear {
                    runningSession.createRunningSession(currentLatitude: 0, currentLongitude: 0)
                }
            }
        }
        .navigationTitle("대기방")
        .navigationBarItems(trailing: Button(action: {
            showStartGroupRunAlter = true
            
            print("button tap to connect")
        }) {
            Text("시작하기")
                .foregroundColor(.blue)
        })
        .alert(isPresented: $showStartGroupRunAlter) {
            Alert(
                title:
                    Text("그룹 러닝을 시작할까요?"),
                primaryButton: .default(Text("시작하기"), action: {
                    webSocketService.connect(runningId: runningSession.latestSessionResponse?.payload.runningKey ?? "error")
                    startGroupRun = true
                }),
                secondaryButton: .cancel(Text("취소"))
            )
        }
        .navigationDestination(isPresented: $startGroupRun, destination:{
            RunGroupPage()
        })
    }
}

#Preview {
    CreateGroupRunPage(noticeContent: .constant("러너에게 아래 인증번호를 알려주세요"), runningSession: RunningSessionService())
}
