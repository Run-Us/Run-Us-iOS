//
//  ProgressBar.swift
//  RunUs
//
//  Created by 가은 on 10/16/24.
//

import SwiftUI

struct ProgressBar: View {
    @State var progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.gray200)
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.highlight)
                    .frame(width: geometry.size.width * min(progress, 1.0)) // 현재는 1km가 max
            }
        }
        .frame(height: 8)
    }
}

#Preview {
    ProgressBar(progress: 0.65)
}
