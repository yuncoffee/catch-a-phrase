//
//  FontStyle.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/05.
//

import Foundation
import SwiftUI

enum CustomFontStyle: String, Hashable {
    case Kr = "NanumMyeongjo-YetHangul"
    case En = "LibreBaskerville-Regular"
}

struct CustomFontModifier: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: CustomFontStyle = .Kr
    var size: Double

    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name.rawValue, size: scaledSize))
    }
}

extension View {
    func customFontModifier(name: CustomFontStyle, size: Double) -> some View {
        return modifier(CustomFontModifier(name: name, size: size))
    }
}
