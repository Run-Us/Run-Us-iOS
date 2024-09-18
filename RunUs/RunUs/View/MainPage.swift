//
//  MainPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/10/24.
//

import SwiftUI

struct MainPage: View {
    @State var showCreateGroupRunPage = false
    @State var showJoinGroupRunPage = false
    var body: some View {
        NavigationStack {
            TabView {
                HomePage()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                CrewPage()
                    .tabItem {
                        Image(systemName: "figure.2")
                        Text("Crew")
                    }
                RunningPage()
                    .tabItem {
                        Image(systemName: "figure.run")
                        Text("Run")
                    }
                
                CharacterPage()
                    .tabItem {
                        Image(systemName: "teddybear.fill")
                        Text("Character")
                    }
                MyPage()
                    .tabItem {
                        Image(systemName: "info.circle")
                        Text("My")
                    }
            }
        }
        
    }
    
}

#Preview {
    MainPage()
}
