//
//  StartPageView.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/25.
//

import SwiftUI

struct StartPageView: View {
    @State
    private var isShowPopover = false
    @State
    private var isShowStage = false
    private let APP_NAME = Bundle.main.appName
    private let btnSize: CGFloat = .btn_inner_medium
    private let btnTouchAreaSize: CGFloat = .btn_outer_medium
    
    var body: some View {
        ContainerView()
    }
}

extension StartPageView {
    // MARK: ContainerView
    private func ContainerView() -> some View {
        let offsetX: CGFloat = 40
        let offsetY: CGFloat = 32
        
        return GeometryReader { geo in
            VStack(spacing: 0) {
                ZStack {
                    Button {
                        self.isShowPopover = true
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: btnSize, height: btnSize)
                            .foregroundColor(.systemGray)
                    }
                    .frame(width: btnTouchAreaSize, height: btnTouchAreaSize)
                    .sheet(isPresented: self.$isShowPopover) {
                        AppDescriptionView()
                    }
                    .position(
                        x: geo.size.width - btnTouchAreaSize - offsetX,
                        y: offsetY
                    )
                    .zIndex(1)
                    VStack(spacing: 0) {
                        TitleView()
                            .padding(.bottom, SharedVM.isIOS ? 32 : 100)
                        StartButtonView()
                            .padding(.horizontal, 24)
                    }
                    .frame(maxWidth: .infinity - 48)
                }
            }
            .background(Color.systemWhite)
            .cornerRadius(16)
            .padding(24)
            .background(Color.systemGray6)
        }
    }
    
    // MARK: TitleView
    private func TitleView() -> some View {
        ZStack {
            if SharedVM.isIOS {
                GraphPaperView(size: 296)
            } else {
                HStack(spacing: -2) {
                    ForEach(0..<2) { _ in
                        GraphPaperView()
                    }
                }
            }
            TextView(
                content: APP_NAME,
                language: .En,
                size: 64
            )
            .multilineTextAlignment(.center)
            .foregroundColor(.systemBlack)
        }
    }
    
    // MARK: StartButtonView
    private func StartButtonView() -> some View {
        Button(action: {
            print("link to select stage!")
            isShowStage.toggle()
        }, label: {
            TextView(content: "Start", language: .En, size: 40)
                .frame(
                    maxWidth: SharedVM.isIOS ? .infinity : 320,
                    maxHeight: 80
                )
                .foregroundColor(.systemBlack)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.systemGray3, lineWidth: 2)
                }
        })
        .navigationDestination(isPresented: $isShowStage) {
            StageListPageView()
        }
    }
    
    // MARK: AppDescriptionView
    private func AppDescriptionView() -> some View {
        VStack {
            ScrollView {
                TextView(content:
                """
                Hello, I’m Coffee.
                
                I'd like to introduce interesting Korean and contents in Korean to you.
                
                There are various Korean contents, but among them,
                I will introduce Korean poems where words and sentences can be interpreted in various ways.
                
                Among the well-known poems in Korea, the first verse picked four especially famous poems.
                
                But wouldn't it be more fun to learn about Hangul together than just looking at it?
                
                Make a morpheme by turning a dial that
                can change the combination of 'Initial consonants', 'Medial vowels', and 'Final consonants', and complete the first phrase.
                
                Soon, you will be able to learn more about Hangul and Korean expressions.
                
                The characteristics of Hangeul, which create a single 'morphism' through the combination of 'Initial consonants', 'Medial vowels', and 'Final consonants'
                
                I'd be very happy if I got interested.
                
                Enjoy Catch a Phrase!
                """, language: .En, size: 24)
                .foregroundColor(.systemBlack)
                .multilineTextAlignment(.leading)
            }
        }
        .padding(24)
    }
}

struct StartPageView_Previews: PreviewProvider {
    static var previews: some View {
        StartPageView()
    }
}
