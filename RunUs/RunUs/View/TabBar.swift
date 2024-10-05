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
            TabView {
                RunningPage()
                    .tabItem {
                        Image(systemName: "figure.run")
                        Text("Run")
                    }
            }
        }
        
    }
    
}

#Preview {
    TabBar()
}
