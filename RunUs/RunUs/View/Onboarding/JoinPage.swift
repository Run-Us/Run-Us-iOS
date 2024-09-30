//
//  JoinPage.swift
//  RunUs
//
//  Created by byeoungjik on 10/1/24.
//

import SwiftUI

struct JoinPage: View {
    @State private var nickname: String = ""
    @State private var email: String = ""
    @State var joinSuccess: Bool = false
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("사용자 정보")) {
                    TextField("닉네임을 입력하세요", text: $nickname)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    TextField("이메일 주소를 입력하세요", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Section {
                    Button(action: {
                        print("닉네임 - \(nickname) : 이메일 - \(email)")
                        joinSuccess = true
                    }, label: {
                            Text("저장")
                    })
                    .disabled(nickname.isEmpty || email.isEmpty)
                    
                }
            }
            .navigationBarTitle("정보 입력")
        }
        .fullScreenCover(isPresented: $joinSuccess) {
            MainPage()
        }
    }
}

#Preview {
    JoinPage()
}
