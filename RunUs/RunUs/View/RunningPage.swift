//
//  RunningPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/9/24.
//

import SwiftUI

struct RunningPage: View {
    @State var showCreateGroupRunPage = false
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    showCreateGroupRunPage = true
                    print("click to group run button : " , showCreateGroupRunPage)
                }, label: {
                    Text("같이 달리기")
                        .foregroundColor(.white)
                        .padding()
                })
                .background(.blue)
                .cornerRadius(10)
                
                Button(action: {
                    
                }, label: {
                    Text("혼자 달리기")
                        .foregroundColor(.white)
                        .padding()
                })
                .background(.blue)
                .cornerRadius(10)
            }
        }
        .navigationDestination(isPresented: $showCreateGroupRunPage, destination:{ StartGroupRunPage()
        })
        
    }
}

#Preview {
    RunningPage()
}
