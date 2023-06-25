//
//  graphPaperView.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/05.
//

import SwiftUI

struct GraphPaperView: View {
    private let lineStyle = StrokeStyle(lineWidth: 2,lineCap: .round, dash: [4, 6])
    var size: CGFloat = 320
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                DottedLine
                    .padding(.leading, 3)
            }
            .padding(.vertical, 20)
            VStack(alignment: .center, spacing: 0) {
                DottedLine
                    .padding(.leading, 3)
            }
            .padding(.vertical, 20)
            .rotationEffect(Angle(degrees: 90))
            Rectangle()
                .border(Color.systemGray4, width: 2)
                .foregroundColor(.clear)
        }
        .frame(width: size, height: size)
    }
}

extension GraphPaperView {
    var DottedLine: some View {
        return ForEach(0..<7) { _ in
            Line().stroke(Color.systemGray4, style: lineStyle)
        }
    }
    
    struct Line: Shape {
        func path(in rect: CGRect) -> Path {
            let start = CGPoint(x: rect.minX, y: rect.midY)
            let end = CGPoint(x: rect.maxX, y: rect.midY)
            
            return Path { p in
                p.move(to: start)
                p.addLine(to: end)
            }
        }
    }
}

struct GraphPaperView_Previews: PreviewProvider {
    static var previews: some View {
        GraphPaperView()
    }
}
