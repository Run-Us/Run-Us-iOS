//
//  GenderPickerSheet.swift
//  RunUs
//
//  Created by byeoungjik on 10/14/24.
//

import SwiftUI

struct GenderPickerSheet: View {
    @Binding var gender: String
    @Binding var showGenderPicker: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 32) {
                Text("성별 선택")
                    .font(.title5_bold)
                    .foregroundColor(.gray900)
                Button(action: {
                    gender = "남성"
                    showGenderPicker = false
                }, label: {
                    Text("남성")
                        .font(.body2_medium)
                        .foregroundColor(.gray700)
                })
                
                Button(action: {
                    gender = "여성"
                    showGenderPicker = false
                }, label: {
                    Text("여성")
                        .font(.body2_medium)
                        .foregroundColor(.gray700)
                })
                
                Button(action: {
                    gender = "기타"
                    showGenderPicker = false
                }, label: {
                    Text("기타")
                        .font(.body2_medium)
                        .foregroundColor(.gray700)
                })
                
            }
            .frame(height: 261)
            .padding()
        }
    }
}

#Preview {
    GenderPickerSheet(gender: .constant(""), showGenderPicker: .constant(false))
}
