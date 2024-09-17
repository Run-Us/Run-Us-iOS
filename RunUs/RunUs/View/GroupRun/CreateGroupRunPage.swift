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
    let grouprunParticipants = ["김현재", "문다훈", "박지혜", "유가은", "이병직", "조성훈"]
    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
                            Text("6531")
                                .font(.system(size: 82, weight: .bold))
                            // 그룹런 참가자
                            List {
                                LazyVGrid(columns: gridLayout, spacing: 20) {
                                    ForEach(grouprunParticipants, id: \.self) { participant in
                                        RunnerParticipant(participantName: participant)
                                    }
                                }
                            }
                            .scrollContentBackground(.hidden)
                        }
                        .padding(.vertical)
                        
                    }
                }
            }
        }
        .navigationTitle("대기방")
        .navigationBarItems(trailing: Button(action: {
            print("그룹런 시작하기")
        }) {
            Text("시작하기")
                .foregroundColor(.blue)
        })
    }
}

#Preview {
    CreateGroupRunPage(noticeContent: .constant("러너에게 아래 인증번호를 알려주세요"))
}
