//
//  FinishRunningPage.swift
//  RunUs
//
//  Created by 가은 on 10/6/24.
//

import SwiftUI

struct FinishRunningPage: View {
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 30) {
                Text("수고하셨습니다")
                    .font(.system(size: 30, weight: .bold))
                runInfoText(type: "시간", info: "")
                runInfoText(type: "거리", info: "")
                runInfoText(type: "평균 페이스", info: "")
                
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - 50)
            
            Button {
                
            } label: {
                Text("다음")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: geometry.size.width - 40)
                    .padding(.vertical, 15)
                    .background(.black)
            }
            .position(x: geometry.size.width / 2 , y: geometry.size.height - 50)
        }
    }
    
    @ViewBuilder
    func runInfoText(type: String, info: String) -> some View {
        HStack {
            Text(type)
            Spacer()
            Text(info)
        }
        .font(.system(size: 18, weight: .semibold))
        .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
        .border(.black)
        .padding(.horizontal, 20)
    }
}

#Preview {
    FinishRunningPage()
}
