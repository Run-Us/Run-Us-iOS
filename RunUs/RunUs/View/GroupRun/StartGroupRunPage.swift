//
//  StartGroupRunPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/16/24.
//

import SwiftUI

struct StartGroupRunPage: View {
    @State var showCreateGroupRunPage = false
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    showCreateGroupRunPage = true
                }, label: {
                    Text("그룹 생성하기")
                        .foregroundColor(.white)
                        .padding()
                })
                .background(.blue)
                .cornerRadius(10)
                
                Button(action: {}, label: {
                    Text("그룹 참가하기")
                        .foregroundColor(.white)
                        .padding()
                })
                .background(.blue)
                .cornerRadius(10)
            }
            
        }
        .navigationDestination(isPresented: $showCreateGroupRunPage, destination:{ 
            CreateGroupRunPage(noticeContent: .constant("러너에게 아래 인증번호를 알려주세요"))
        })
    }
}

#Preview {
    StartGroupRunPage()
}
