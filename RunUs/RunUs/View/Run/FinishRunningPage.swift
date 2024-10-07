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
    @State private var showShareRecordPage: Bool = false
    
    init(mapVM: MapViewModel) {
        self.mapVM = mapVM
        runningInfo = mapVM.motionManager.runningInfo
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 30) {
                    Text("수고하셨습니다")
                        .font(.system(size: 30, weight: .bold))
                    runInfoText(type: "시간", info: runningInfo.runningTime ?? "0:00")
                    runInfoText(type: "거리", info: String(format: "%.2fkm", runningInfo.distance ?? 0.0))
                    runInfoText(type: "평균 페이스", info: runningInfo.averagePace ?? "-' --''")
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - 50)
                
                Button {
                    showShareRecordPage = true
                } label: {
                    Text("다음")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: geometry.size.width - 40)
                        .padding(.vertical, 15)
                        .background(.black)
                }
                .position(x: geometry.size.width / 2 , y: geometry.size.height - 50)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $showShareRecordPage) {
            ShareRunningRecordPage(mapVM: mapVM)
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
    FinishRunningPage(mapVM: MapViewModel())
}
