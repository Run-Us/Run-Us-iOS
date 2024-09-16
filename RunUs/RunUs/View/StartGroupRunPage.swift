//
//  StartGroupRunPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/16/24.
//

import SwiftUI

struct StartGroupRunPage: View {
    var body: some View {
        ZStack {
            VStack {
                //                Spacer()
                Button(action: {}, label: {
                    Text("그룹 생성하기")
                        .foregroundColor(.white)
                        .padding()
                })
                .background(.blue)
                .cornerRadius(10)
                
                Button(action: {}, label: {
                    Text("그룹 참가하기")
                        .foregroundColor(.white)
                        .padding()
                })
                .background(.blue)
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    StartGroupRunPage()
}
