//
//  RunningPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/9/24.
//

import SwiftUI

struct RunningPage: View {
    @State var showGroupRun = false
    var body: some View {
        ZStack {
            VStack {
                NavigationLink(destination: StartGroupRunPage(joinCode: "", runningSession: RunningSessionService()), label: {
                    Text("같이 달리기")
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .cornerRadius(10)
                })
                
                NavigationLink(destination: RunAlonePage()) {
                    Text("혼자 달리기")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    RunningPage()
}
