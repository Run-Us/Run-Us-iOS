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
                RunningPage()
                    .tabItem {
                        Image(systemName: "figure.run")
                        Text("Run")
                    }
                MyPage()
                    .tabItem {
                        Label("My", systemImage: "person.circle")
                    }
            }
        }
        
    }
    
}

#Preview {
    MainPage()
}
