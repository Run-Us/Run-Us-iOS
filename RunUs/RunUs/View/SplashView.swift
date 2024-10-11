//
//  SplashView.swift
//  RunUs
//
//  Created by byeoungjik on 10/12/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(.tone)
            Image("SplashLogo")
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}

