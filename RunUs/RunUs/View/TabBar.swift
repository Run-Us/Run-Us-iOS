//
//  MainPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/10/24.
//

import SwiftUI

enum Tab {
    case home
    case run
    case my
}

struct TabBar: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        NavigationStack {
            VStack {
                // 상단 바
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Image("logo_black")
                            .resizable()
                            .frame(width: 104, height: 24)
                    }
                    .padding(16)
                    Divider()
                }
                
                // 커스텀 탭바
                VStack {
                    Spacer()
                    
                    // 탭 별 보여줄 페이지
                    switch (selectedTab) {
                    case .home: HomeTab()
                    case .my:   MyTab()
                    default: EmptyView()
                    }
                    
                    Spacer()
                    
                    // 탭 아이콘
                    HStack {
                        Spacer()
                        
                        // 홈
                        Button {
                            selectedTab = .home
                        } label: {
                            Image("tab_home")
                                .renderingMode(.template)
                                .foregroundStyle(selectedTab == .home ? .gray900 : .gray400)
                        }
                        
                        Spacer()
                        
                        // 달리기
                        Button {
                            selectedTab = .run
                        } label: {
                            Image("tab_play")
                        }
                        .offset(y: -10)
                        
                        Spacer()
                        
                        // 마이페이지
                        Button {
                            selectedTab = .my
                        } label: {
                            Image("tab_user")
                                .renderingMode(.template)
                                .foregroundStyle(selectedTab == .my ? .gray900 : .gray400)
                        }
                        
                        Spacer()
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    TabBar()
}
