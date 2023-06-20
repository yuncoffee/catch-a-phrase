//
//  TextView.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/05.
//

import SwiftUI

struct TextView: View {
    var content: String
    var language: CustomFontStyle = .Kr
    var size: Double = 16
    
    var body: some View {
        Text(content)
            .customFontModifier(name: language, size: size)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(content: "Hello")
    }
}
