//
//  AddProfileSheet.swift
//  RunUs
//
//  Created by byeoungjik on 10/14/24.
//

import SwiftUI

struct AddProfileSheet: View {
    @Binding var showAddProfile: Bool
    
    var body: some View {
        GeometryReader { geomtry in
            VStack(alignment: .leading, spacing: 34) {
                Text("프로필 사진 추가")
                    .font(.title5_bold)
                    .foregroundColor(.gray900)
                    .padding(.top, 16)
                
                Button(action: {
                    showAddProfile = false
                }, label: {
                    HStack {
                        Image("imageIcon")
                        Text("갤러리에서 추가하기")
                            .font(.body2_medium)
                            .foregroundColor(.gray700)
                    }
                })
            }
            .padding()
        }
        .onDisappear(perform: {
            showAddProfile = false
        })
    }
}

#Preview {
    AddProfileSheet(showAddProfile: .constant(false))
}
