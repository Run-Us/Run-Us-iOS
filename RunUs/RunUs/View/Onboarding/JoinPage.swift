//
//  JoinPage.swift
//  RunUs
//
//  Created by byeoungjik on 10/1/24.
//

import SwiftUI

struct JoinPage: View {
    @ObservedObject var joinService: JoinService = JoinService()
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    @Binding var loginSuccess: Bool
    @State private var nickname: String = ""
    @State private var nicknameIsValid: Bool = true
    @State var gender = "성별을 선택해주세요"
    @State var showGenderPicker = false
    @State var showAddProfile = false
    @FocusState private var isTextFieldFocused: Bool
    let userInfo = UserDefaults.standard
    
    var body: some View {
        NavigationView {
            VStack(alignment:.center) {
                
                Text("만나서 반가워요!")
                    .font(.title4_semibold)
                    .padding(8)
                Text("러너 프로필을 만들어 볼까요?")
                    .font(.body2_medium)
                    .foregroundColor(.gray500)
                
                Image("default_user_profile")
                    .overlay {
                        Button(action: {
                            showAddProfile = true
                            print("add profile")
                        }, label: {
                            Image("plus_profile_button")
                        })
                        .offset(x: 30, y: 30)
                    }
                    .padding(36)
                    .sheet(isPresented: $showAddProfile, content: {
                        AddProfileSheet()
                            .presentationDetents([.fraction(0.15)])
                    })
                
                VStack(alignment: .leading) {
                    Text("닉네임")
                        .font(.body1_bold)
                        .foregroundColor(nicknameIsValid ? .gray700 : .error)
                        .padding(.horizontal)
                    
                    TextField("한글, 영어, 숫자만 입력 가능해요", text: $nickname)
                        .onChange(of: nickname) { newValue in
                            nicknameIsValid = newValue.count <= 8 && !containsSpecialCharacters(text: newValue)
                        }
                        .focused($isTextFieldFocused)
                        .autocapitalization(.none)
                        .disableAutocorrection(false)
                        .foregroundColor(nickname.count > 0 ? .gray900 : .gray500)
                        .cornerRadius(8)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(!nicknameIsValid ? .error :
                                            nickname.count > 0 ? .gray700 : .gray300, lineWidth: 1)
                        )
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                }
                
                HStack {
                    Text("\(containsSpecialCharacters(text: nickname) ? "사용할 수 없는 문자가 포함되어 있어요" : nickname.count <= 8 ? "" : "닉네임은 8자 이내로 설정할 수 있어요" )")
                        .font(.caption_regular)
                        .foregroundColor(nicknameIsValid ? .gray400 : .error)
                    Spacer()
                    Text("\(nickname.count)/8")
                        .font(.caption_regular)
                        .foregroundColor(nicknameIsValid ? .gray400 : .error)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("성별")
                        .font(.body1_bold)
                        .foregroundColor(.gray700)
                    Spacer()
                    Button(action: {
                        showGenderPicker = true
                        print("add gender")
                    }, label: {
                        Text("\(gender)")
                            .font(.body1_medium)
                            .foregroundColor(.gray700)
                    })
                }
                .padding()
                Spacer()
                
                Divider()
                
                Button(action: {
                    print("닉네임 - \(nickname) : 성별 - \(gender)")
                    
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 361, height: 56)
                            .foregroundColor(nickname.isEmpty || gender == "성별을 선택해주세요" || !nicknameIsValid ? .gray300 : .primary400)
                        Text("시작하기")
                            .font(.title5_bold)
                            .foregroundColor(.white)
                    }
                })
                .disabled(nickname.count <= 2 || gender == "성별을 선택해주세요" || !nicknameIsValid)
                .sheet(isPresented: $showGenderPicker, content: {
                    GenderPickerSheet(gender: $gender, showGenderPicker: $showGenderPicker)
                        .presentationDetents([.fraction(0.25)])
                })
            }
            .padding(.top, 24)
            
        }
        .onTapGesture {
            isTextFieldFocused = false
        }
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.gray900)
            Text("프로필 설정")
                .font(.body1_medium)
                .foregroundColor(.gray900)
            
        })
        
    }
    
    func containsSpecialCharacters(text: String) -> Bool {
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[^A-Za-z0-9가-힣]")
        return regex.firstMatch(in: text, options: [], range: range) != nil
    }
}


#Preview {
    JoinPage(loginSuccess: .constant(false))
}
