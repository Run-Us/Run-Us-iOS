//
//  NoticeBar.swift
//  RunUs
//
//  Created by byeoungjik on 9/16/24.
//

import SwiftUI

struct NoticeBar: View {
    @Binding var noticeContent: String?
    
    var body: some View {
        ZStack {
            Color(.black)
            HStack(alignment: .center){
                if let notice = noticeContent {
                    Text(notice)
                        .foregroundColor(.white)
                }
            }
        }
        .frame(height: 40)
        .ignoresSafeArea(edges: .horizontal)
    }
    
    
}

#Preview {
    NoticeBar(noticeContent: .constant("러너에게 아래의 인증번호를 알려주세요"))
    
}
