//
//  FinishRunningPage.swift
//  RunUs
//
//  Created by 가은 on 10/6/24.
//

import SwiftUI

struct FinishRunningPage: View {
    var mapVM: MapViewModel
    var runningInfo: RunningInfo
    @State private var showRunningPostPage: Bool = false
    @State private var title: String = ""
    @State private var explanation: String = ""
    
    init(mapVM: MapViewModel) {
        self.mapVM = mapVM
        runningInfo = mapVM.motionManager.runningInfo
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                Divider()
                VStack(spacing: 25) {
                    // 지도 이미지
                    
                    // 제목
                    textField(title: "제목", contents: $title, maxCount: 20)
                    
                    // 설명
                    textField(title: "설명", contents: $explanation, maxCount: 200)
                    
                    Spacer()
                    
                    // 저장 버튼
                    Button {
                        showRunningPostPage = true
                    } label: {
                        Text("저장하기")
                            .font(.title5_bold)
                            .foregroundStyle(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: geometry.size.width - 32, height: 56)
                            )
                    }
                }
                .padding(16)

            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 6) {
                        Button {
                            // TODO: 활동 삭제 팝업 띄우기
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 14, height: 14)
                        }
                        Text("활동 저장하기")
                            .font(.body1_medium)
                    }
                    .foregroundStyle(.gray900)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $showRunningPostPage) {
            RunningPostPage(mapVM: mapVM, runningPost: RunningPost(title: title, contents: explanation, runningInfo: runningInfo))
        }
    }
    
    @ViewBuilder
    func textField(title: String, contents: Binding<String>, maxCount: Int) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.body1_bold)
            ZStack(alignment: .topLeading) {
                // input text
                TextEditor(text: contents)
                    .font(.body2_medium)
                    .padding(8)
                    .frame(height: title == "제목" ? 47 : 110)
                    .foregroundColor(.gray900)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(contents.wrappedValue.count > 0 ? .gray700 : .gray300)
                    )
                // placeholder
                if contents.wrappedValue.isEmpty {
                    Text(title == "제목" ? "이 활동의 제목을 지어주세요" : "오늘 러닝은 어떠셨는지 궁금해요")
                        .font(.body2_medium)
                        .foregroundStyle(.gray500)
                        .padding(EdgeInsets(top: 15, leading: 12, bottom: 15, trailing: 12))
                }
            }

            // 글자수
            HStack {
                Spacer()
                Text("\(contents.wrappedValue.count)/\(maxCount)")
                    .foregroundStyle(.gray400)
                    .font(.caption_regular)
            }
        }
    }
}

#Preview {
    FinishRunningPage(mapVM: MapViewModel())
}
