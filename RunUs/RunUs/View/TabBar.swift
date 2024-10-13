//
//  MainPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/10/24.
//

import SwiftUI

struct TabBar: View {
    
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
                // 탭
                TabView {
                    HomeTab()
                        .tabItem {
                            Image("tab_home")
                                .renderingMode(.template)
                        }
                    RunningPage()
                        .tabItem {
                            Image("tab_play")
                        }
                    MyTab()
                        .tabItem {
                            Image("tab_user")
                                .renderingMode(.template)
                        }
                }
                .accentColor(.gray900)
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    TabBar()
}
