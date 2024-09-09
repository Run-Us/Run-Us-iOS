//
//  MainPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/10/24.
//

import SwiftUI

struct MainPage: View {
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                }
            CrewPage()
                .tabItem {
                    Image(systemName: "figure.2")
                }
            RunningPage()
                .tabItem { 
                    Image(systemName: "figure.run")
                }
            CharacterPage()
                .tabItem {
                    Image(systemName: "hare.fill")
                }
            MyPage()
                .tabItem {
                    Image(systemName: "info.circle")
                }
        }
    }
}

#Preview {
    MainPage()
}
