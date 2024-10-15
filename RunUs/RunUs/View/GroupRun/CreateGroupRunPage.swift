//
//  CreateGroupRunPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/16/24.
//

import SwiftUI

struct CreateGroupRunPage: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var mapVM: MapViewModel
    @State var noticeBar = NoticeBar(noticeContent: .constant("러너에게 아래 인증번호를 알려주세요"))
    @ObservedObject var runningSession: RunningSessionService
    @StateObject var participationService = ParticipationService()
    @State var showStartGroupRunAlter = false
    @State var startGroupRun = false
    
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
                            Text(runningSession.latestSessionResponse?.payload.passcode ?? "error")
                                .font(.system(size: 82, weight: .bold))
                            if participationService.participantNames.isEmpty {
                                EmptyView()
                            } else {
                                ParticipantList(grouprunParticipants: participationService.participantNames)
                            }
                            
                        }
                        .padding(.vertical)
                        
                    }
                }
            }
        }
        .onAppear {
            print("getParticipantList || runningId: \(runningSession.latestSessionResponse?.payload.runningKey ?? "empty")")
            participationService.getParticipantList(runningId: runningSession.latestSessionResponse?.payload.runningKey ?? "") { success in
                if !success {
                    print("참가자 정보 불러오기 실패")
                }
                else {
                    print("getParticipantList || response: \(success)")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 10) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 8, height: 14)
                    })
                    Text("대기방")
                        .font(.body1_medium)
                }
            }
        }
        .foregroundStyle(.gray900)
        .alert(isPresented: $showStartGroupRunAlter) {
            Alert(
                title: Text("그룹 러닝을 시작할까요?"),
                primaryButton: .default(Text("시작하기"), action: {
                    let startRunningInfo = [
                        "userId": UserDefaults.standard.string(forKey: "userId") ?? "",
                        "runningId": runningSession.latestSessionResponse?.payload.runningKey ?? "",
                        "runningKey": runningSession.latestSessionResponse?.payload.runningKey ?? ""
                    ]
                    WebSocketService.sharedSocket.sendMessage(body: startRunningInfo, destination: "/app/runnings/start")
                    startGroupRun = true
                }),
                secondaryButton: .cancel(Text("취소"))
            )
        }
        .navigationDestination(isPresented: $startGroupRun, destination:{
            RunningPage(runningType: .group, mapVM: mapVM)
        })
    }
}

#Preview {
    CreateGroupRunPage(mapVM: .init(), runningSession: RunningSessionService())
}
