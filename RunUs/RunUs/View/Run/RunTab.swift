//
//  RunTab.swift
//  RunUs
//
//  Created by 가은 on 10/14/24.
//

import SwiftUI

struct RunTab: View {
    @State private var selectedRunning = 0
    let typeOfRunning = ["혼자 달리기", "그룹 달리기"]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // toolbar와 구분
                    Divider()
                    
                    // Segmented Picker
                    HStack {
                        ForEach(0..<typeOfRunning.count, id: \.self) { index in
                            Spacer()
                            Button {
                                selectedRunning = index
                            } label: {
                                Text(typeOfRunning[index])
                                    .font(.body1_medium)
                                    .foregroundStyle(selectedRunning == index ? .gray900 : .gray400)
                                    .padding(.vertical, 15)
                            }
                            Spacer()
                        }
                    }
                    
                    switch(selectedRunning) {
                    case 0: EmptyView()
                    case 1: EmptyView()
                    default: EmptyView()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        VStack {
                            Button {
                                
                            } label: {
                                HStack {
                                    Image("back_button")
                                    Text("달리기")
                                        .font(.body1_medium)
                                }
                                .foregroundStyle(.gray900)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RunTab()
}
