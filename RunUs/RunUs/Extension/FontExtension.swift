//
//  FontExtension.swift
//  RunUs
//
//  Created by 가은 on 9/4/24.
//

import Foundation
import SwiftUI

enum FontName {
    static let pretendardBold = "Pretendard-Bold"
    static let pretendardMedium = "Pretendard-Medium"
}

/*
    사용 방법 (행&글자 간 간격은 별도 지정 필요)
 
    Text()
        .font(.title1)
 */
extension Font {
    static let title1: Font = .custom(FontName.pretendardBold, size: 30)
    static let title2: Font = .custom(FontName.pretendardBold, size: 26)
    static let body1: Font = .custom(FontName.pretendardMedium, size: 17)
    static let body2: Font = .custom(FontName.pretendardMedium, size: 13)
    static let caption: Font = .custom(FontName.pretendardMedium, size: 11)
}
