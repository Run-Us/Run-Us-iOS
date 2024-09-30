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
    @State var joinCode: String
    var body: some View {
        ZStack {
            VStack {
                NavigationLink(destination: CreateGroupRunPage(noticeContent: .constant("러너에게 아래 인증번호를 알려주세요"), runningSession: RunningSessionService()), label: {
                    Text("그룹 생성하기")
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .cornerRadius(10)
                })
                
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
            JoinGroupRunPage()
        })

    }
        
}

#Preview {
    StartGroupRunPage(joinCode: "")
}
