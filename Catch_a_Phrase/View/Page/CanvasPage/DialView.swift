//
//  DialView.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/27.
//

import SwiftUI

struct DialView: View {
    @StateObject
    var dialVM = DialVM()
    @StateObject
    var canvasVM: CanvasVM

    @State
    private var isAnimationStart = false
    
    var body: some View {
        VStack {
            CurrentScriptView()
            CurrentDialView()
        }
        .onReceive(dialVM.$krScalers) { _ in
            dialVM.updateCurrentCharcter(store: canvasVM)
        }
    }
}

extension DialView {
    private func CurrentScriptView() -> some View {
        let fontSize: CGFloat = 64

        return VStack(spacing: 4) {
            HStack(spacing: 0) {
                TextView(content: canvasVM.correctWord, size: fontSize)
                    .foregroundColor(Color(UIColor.label))
                TextView(content: canvasVM.correctYetWord, size: fontSize)
                    .foregroundColor(.systemGray3)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scaleEffect(canvasVM.isWrongAnswerSubmited)
            .animation(.spring(response: 0.1, dampingFraction: 0.2, blendDuration: 0).repeatCount(3, autoreverses: true), value: canvasVM.isWrongAnswerSubmited)
            .onChange(of: canvasVM.isWrongAnswerSubmited) { newValue in
                if newValue == 0.9 {
                    isAnimationStart = true
                } else {
                    isAnimationStart = false
                }
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
                // 좌측 초성 다이얼
                CharacterDialView()
                    .rotationEffect(Angle(degrees: Double(dialVM.totalRotates[0].height)))
                    .gesture(rotationLeft)
                    .animation(
                        .spring(
                            response: 0.5,
                            dampingFraction: 0.6,
                            blendDuration: 0
                        ),
                        value: dialVM.totalRotates[0]
                    )
                    .position(x: -132, y: geo.size.height / 2 - 24)
                // 우측 중성 다이얼
                CharacterDialView()
                    .rotationEffect(Angle(degrees: Double(-dialVM.totalRotates[1].height)))
                    .gesture(rotationRight)
                    .animation(
                        .spring(
                            response: 0.5,
                            dampingFraction: 0.6,
                            blendDuration: 0
                        ),
                        value: dialVM.totalRotates[1]
                    )
                    .position(
                        x: geo.size.width + 132,
                        y: geo.size.height / 2 - 24
                    )
                // 아래쪽 종성 다이얼
                CharacterDialView()
                    .rotationEffect(Angle(degrees: Double(dialVM.totalRotates[2].width)))
                    .gesture(rotationBtm)
                    .animation(
                        .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0),
                        value: dialVM.totalRotates[2]
                    )
                    .position(x: geo.size.width / 2, y: geo.size.height / 2 + 340)
                DragableTextBoxView(canvasVM: canvasVM, krScalers: $dialVM.krScalers)
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
                    .offset(y: dialVM.isShowAnimation ? -8 : 0)
                    .animation(.easeIn(duration: 0.4).repeatForever( autoreverses: true),
                               value: dialVM.isShowAnimation
                    )
                    .opacity(dialVM.isShowAnimation ? 1 : 0)
            }
        }
    }

    private func CharacterDialView() -> some View {
        ZStack {
            ForEach(0 ..< 360) { deg in
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

// MARK: Gesutre Info

extension DialView {
    private var rotationLeft: some Gesture {
        DragGesture()
            .onChanged { value in
                dialVM.totalRotates[0].height = value.translation.height + dialVM.currentRotates[0].height
            }
            .onEnded { _ in
                dialVM.currentRotates[0] = dialVM.totalRotates[0]
            }
    }

    private var rotationRight: some Gesture {
        DragGesture()
            .onChanged { value in
                dialVM.totalRotates[1].height = value.translation.height + dialVM.currentRotates[1].height
            }
            .onEnded { _ in
                dialVM.currentRotates[1] = dialVM.totalRotates[1]
            }
    }

    private var rotationBtm: some Gesture {
        DragGesture()
            .onChanged { value in
                dialVM.totalRotates[2].width = value.translation.width + dialVM.currentRotates[2].width
            }
            .onEnded { _ in
                dialVM.currentRotates[2] = dialVM.totalRotates[2]
            }
    }
}

struct DialView_Previews: PreviewProvider {
    static var previews: some View {
        DialView(canvasVM: CanvasVM())
    }
}
