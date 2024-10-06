//
//  ShareRunningRecordPage.swift
//  RunUs
//
//  Created by 가은 on 10/6/24.
//

import SwiftUI

struct ShareRunningRecordPage: View {
    @StateObject var mapVM: MapViewModel
    @State private var runningTitle: String = ""
    @State private var runningContents: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                HStack {
                    Text("피드에 저장하기")
                        .font(.system(size: 25, weight: .bold))
                    Spacer()
                }
                HStack {
                    Text("나의 기록을 저장하고, 크루에 공유해보세요!")
                    Spacer()
                }
                
                MapPage(mapVM: mapVM)
                    .frame(height: max(geometry.size.width - 20, 0))
                
                VStack(spacing: 15) {
                    inputContents(title: "제목", contents: "힘차게 모닝런", text: $runningTitle)
                    Divider()
                    inputContents(title: "설명", contents: "오늘의 러닝에 대해 적어주세요", text: $runningContents)
                }
                .padding()
            }
            .frame(width: max(geometry.size.width - 20, 0))
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - 30)
        }
        .navigationBarBackButtonHidden()
    }
    
    
    @ViewBuilder
    func inputContents(title: String, contents: String, text: Binding<String>) -> some View {
        HStack(spacing: 20) {
            Text(title)
                .font(.system(size: 17))
            TextField(contents, text: text)
                .font(.system(size: 15))
                .onAppear {
                    // text clear button
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
        }
        
    }
}

#Preview {
    ShareRunningRecordPage(mapVM: .init())
}
