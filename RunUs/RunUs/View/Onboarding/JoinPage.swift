//
//  JoinPage.swift
//  RunUs
//
//  Created by byeoungjik on 10/1/24.
//

import SwiftUI

struct JoinPage: View {
    @Environment(\.dismiss) var dismiss
    @State private var nickname: String = ""
    @State private var email: String = ""
    @Binding var loginSuccess: Bool
    @ObservedObject var joinService: JoinService = JoinService()
    let userInfo = UserDefaults.standard
    @State var gender = "성별을 선택해주세요"
    @State var showGenderPicker = false
    
    var body: some View {
        NavigationView {
            VStack(alignment:.center) {
                
                Text("만나서 반가워요!")
                    .font(.title4_semibold)
                Text("러너 프로필을 만들어 볼까요?")
                    .font(.body2_medium)
                    .foregroundColor(.gray500)
                    .padding(8)
                Image("default_user_profile")
                    .overlay {
                        Button(action: {
                            
                        }, label: {
                            Image("plus_profile_button")
                        })
                        .offset(x: 30, y: 30)
                    }
                
                HStack {
                    Text("닉네임")
                        .font(.body1_bold)
                        .foregroundColor(.gray700)
                    Spacer()
                }
                .padding(.horizontal)
                
                TextField("한글, 영어, 숫자만 입력 가능해요", text: $nickname)
                    .autocapitalization(.none)
                    .disableAutocorrection(false)
                    .foregroundColor(.gray500)
                    .cornerRadius(8)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray300, lineWidth: 1)
                    )
                    .padding()
                
                HStack {
                    Text("성별")
                        .font(.body1_bold)
                        .foregroundColor(.gray700)
                    Spacer()
                    Button(action: {
                        showGenderPicker = true
                    }, label: {
                        Text("\(gender)")
                            .font(.body2_medium)
                            .foregroundColor(.gray500)
                    })
                }
                .padding(.horizontal)
                Spacer()
                
                Divider()
                
                Button(action: {
                    print("닉네임 - \(nickname) : 이메일 - \(gender)")
                    
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 361, height: 56)
                        Text("시작하기")
                    }
                })
                .disabled(nickname.isEmpty || email.isEmpty)
                .sheet(isPresented: $showGenderPicker, content: {
                    GenderPickerSheet(gender: $gender, showGenderPicker: $showGenderPicker)
                        .presentationDetents([.medium])
                })
            }
            
        }
        .navigationBarItems(leading: Text("프로필 설정")
            .font(.body1_medium)
            .foregroundColor(.gray900))
        
    }
}


#Preview {
    JoinPage(loginSuccess: .constant(false))
}
