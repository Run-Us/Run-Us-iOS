//
//  MyPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/9/24.
//

import SwiftUI

struct MyPage: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Button(action: {
                UserDefaults.standard.removeObject(forKey: "idToken")
                UserDefaults.standard.removeObject(forKey: "userId")
                dismiss()
            }, label: {
                Text("로그아웃")
                    .foregroundColor(.white)
                    .padding()
            })
            .background(.blue)
            .cornerRadius(10)
        }
    }
}

#Preview {
    MyPage()
}
