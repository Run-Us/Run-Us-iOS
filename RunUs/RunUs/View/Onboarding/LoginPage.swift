//
//  LoginPage.swift
//  RunUs
//
//  Created by 가은 on 9/4/24.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var authVM: AuthViewModel = AuthViewModel()
    @State private var loginSuccess: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                Text("Run with Us!")
                    .font(.title1)
                Text("모든 러너가 즐겁게 성장하며\n함께 달릴 수 있는 러닝 크루 플랫폼")
                    .font(.body1)
                    .lineSpacing(0.8)
                Button(action: {
                    authVM.kakaoLogin { isSuccess in
                        loginSuccess = isSuccess
                    }
                }, label: {
                    Image("kakao_login_button")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .fullScreenCover(isPresented: $loginSuccess) {
                    MainPage()
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    LoginPage()
}