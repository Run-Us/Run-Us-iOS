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
    
    init() {
        // kakao sdk 초기화
        let kakaoNativeAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoNativeAppKey as! String)
    }
    
    var body: some Scene {
        WindowGroup {
            LoginPage()
                .onOpenURL(perform: { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                })
        }
    }
}
