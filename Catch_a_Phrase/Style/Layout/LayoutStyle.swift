//
//  LayoutStyle.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/27.
//

import Foundation
import SwiftUI

struct WhiteBackgroundContainerStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(16)
    }
}

extension View {
    func whiteBackgroundContainerStyleModifier() -> some View {
        return modifier(WhiteBackgroundContainerStyleModifier())
    }
}
