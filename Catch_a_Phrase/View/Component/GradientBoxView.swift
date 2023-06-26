//
//  GradientBoxView.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/26.
//

import SwiftUI

struct GradientBoxView: View {
    @Environment(\.colorScheme)
    private var colorScheme
    
    private var gradientStart_light = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
    private var gradientEnd_light = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    
    private var gradientStart_dark = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
    private var gradientEnd_dark = Color(UIColor.systemBackground)
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(
                gradient: .init(colors: colorScheme == .light
                    ? [gradientStart_light, gradientEnd_light]
                    : [gradientStart_dark, gradientEnd_dark]
               ),
              startPoint: .init(x: 0.5, y: 0),
              endPoint: .init(x: 0.5, y: 0.6)
            ))
    }
}

struct GradientBoxView_Previews: PreviewProvider {
    static var previews: some View {
        GradientBoxView()
    }
}
