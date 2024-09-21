//
//  JoinGroupRunPage.swift
//  RunUs
//
//  Created by byeoungjik on 9/22/24.
//

import SwiftUI

struct JoinGroupRunPage: View {
    @State var noticeBar = NoticeBar(noticeContent: .constant("곧 그룹 러닝이 시작됩니다!"))
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    MapPage(mapVM: .init())
                    VStack {
                        noticeBar
                            .frame(width: geometry.size.width)
                            .padding(.top, 40)
                        Spacer()
                    }
                }
                ParticipantList()
            }
        }
    }
}

#Preview {
    JoinGroupRunPage()
}
