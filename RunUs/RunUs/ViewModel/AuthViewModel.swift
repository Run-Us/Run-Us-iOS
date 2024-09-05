//
//  AuthViewModel.swift
//  RunUs
//
//  Created by 가은 on 9/5/24.
//

import Foundation
import KakaoSDKUser

class AuthViewModel: ObservableObject {
    
    func kakaoLogin() {
        // 카카오톡 실행 가능 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 로그인
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    
                    print("카카오톡 로그인 success")
                }
            }
        } else {
            // 카카오계정 로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("카카오계정 로그인 success")
                }
            }
        }
    }
}
