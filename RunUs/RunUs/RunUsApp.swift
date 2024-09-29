//
//  RunUsApp.swift
//  RunUs
//
//  Created by 가은 on 8/31/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct RunUsApp: App {
    @StateObject var authVM: AuthViewModel = AuthViewModel()
    
    init() {
        // kakao sdk 초기화
        let kakaoNativeAppKey = (Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String) ?? ""
        KakaoSDK.initSDK(appKey: kakaoNativeAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            // token이 있으면 바로 MainPage로 이동
            if authVM.checkTokenExists() {
                MainPage()
            } else {
                LoginPage()
                    .onOpenURL(perform: { url in
                        if AuthApi.isKakaoTalkLoginUrl(url) {
                            _ = AuthController.handleOpenUrl(url: url)
                        }
                    })
            }
        }
    }
}
