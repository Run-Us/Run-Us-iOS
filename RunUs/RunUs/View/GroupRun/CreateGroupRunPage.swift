//
//  CreateGroupRunPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/16/24.
//

import SwiftUI

struct CreateGroupRunPage: View {
    let screenWidth = UIScreen.main.bounds.size.width
    @Binding var noticeContent: String?
    @State var noticeBar = NoticeBar(noticeContent: .constant("러너에게 아래 인증번호를 알려주세요"))
    var body: some View {
        ZStack {
            VStack {
//                알림창
                noticeBar
                    .frame(width: screenWidth, height: 40)
                    .padding()
//                인증번호
                Text("인증번호")
                Text("6531")
                    .font(.system(size: 82, weight: .bold))
//                참가자
                List {
//                    mokup
                    RunnerParticipant()
//                    .listRowBackground(.clear)
                }
                .listRowSeparator(.hidden)
                
            }
        }
    }
}

#Preview {
    CreateGroupRunPage(noticeContent: .constant("러너에게 아래 인증번호를 알려주세요"))
}
