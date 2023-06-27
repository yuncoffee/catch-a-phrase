//
//  DialView.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/27.
//

import SwiftUI

struct DialView: View {
    var body: some View {
        VStack {
            /// CurrentScriptView
            CurrentScriptView()
            
            
            /// CurrnetDialView
            CurrentDialView()
        }
        
    }
}

extension DialView {
    private func CurrentScriptView() -> some View {
        let fontSize: CGFloat = 64
        
        return VStack(spacing: 4) {
            HStack(spacing: 0) {
                TextView(content: "맞춤", size: fontSize)
                    .foregroundColor(Color(UIColor.label))
                TextView(content: "맞춰야", size: fontSize)
                    .foregroundColor(.systemGray3)
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .padding(.vertical, 16)
            Divider()
                .frame(height: 2)
                .background(Color.systemGray4)
        }
        .frame(maxWidth: .infinity)
        
    }
    
    private func CurrentDialView() -> some View {
        GeometryReader { geo in
            ZStack {
                CharacterDialView()
                CharacterDialView()
                CharacterDialView()
            }
        }
    }
    
    private func CharacterDialView() -> some View {
        ZStack {
            ForEach(0..<360) { deg in
                let isMarkableTic = deg % 4 == 0
                if deg % 6 == 0 {
                    Rectangle()
                        .frame(width: isMarkableTic ? 380 : 385, height: isMarkableTic ? 2 : 4)
                        .rotationEffect(Angle(degrees: Double(deg)))
                        .foregroundColor(isMarkableTic ? Color.systemGray3 : Color(UIColor.label))
                }
            }
            Circle()
                .foregroundColor(Color(UIColor.systemBackground))
                .frame(width: 360)
        }
    }
}

struct DialView_Previews: PreviewProvider {
    static var previews: some View {
        DialView()
    }
}
