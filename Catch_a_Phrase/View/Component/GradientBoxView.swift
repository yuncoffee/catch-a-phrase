//
//  GradientBoxView.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/26.
//

import SwiftUI

struct GradientBoxView: View {
    private var gradientStart = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
    private var gradientEnd = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(
              gradient: .init(colors: [gradientStart, gradientEnd]),
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
