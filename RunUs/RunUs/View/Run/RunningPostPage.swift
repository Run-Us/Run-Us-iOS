//
//  RunningPostPage.swift
//  RunUs
//
//  Created by 가은 on 10/22/24.
//

import SwiftUI

struct RunningPostPage: View {
    @StateObject var mapVM: MapViewModel
    @State private var showNextPage: Bool = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                Divider()
                
                VStack {
                    // 유저 정보
                    HStack(spacing: 24) {
                        // 프로필 사진
                        Image("default_user_profile")
                            .resizable()
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("닉네임")
                                .font(.title5_medium)
                            Text("2024년 9월 25일 (목) 오후 4:24")
                                .font(.caption_regular)
                                .foregroundStyle(.gray500)
                        }
                    }
                    
                    // title
                    
                    // 완료한 러닝 정보
                    
                    // contents
                    
                    // 지도 이미지
                    
                    // 구간별 페이스
                    
                }
                .foregroundStyle(.gray900)
                .padding(.horizontal, 16)
                .padding(.vertical, 25)
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 6) {
                        Button {
                            
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 14, height: 14)
                        }
                        Text("내 활동")
                            .font(.body1_medium)
                    }
                    .foregroundStyle(.gray900)
                }
            }
            .navigationDestination(isPresented: $showNextPage) {
                TabBar()
            }
        }
    }
}

#Preview {
    RunningPostPage(mapVM: .init())
}
