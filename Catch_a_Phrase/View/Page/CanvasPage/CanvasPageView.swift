//
//  CanvasPageView.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/26.
//

import SwiftUI

struct CanvasPageView: View {
    @State
    private var isShowPopOver: Bool = false
    @StateObject
    var canvasVM = CanvasVM()
    var currentIndex: Int
    var poem: Poem
    
    var body: some View {
        ContainerView()
            .toolbar {
                ShowPlayRuleButtonView()
            }
            .navigationTitle("Playground")
            .onAppear {
                canvasVM.currentPoemIndex = currentIndex
                canvasVM.currentFirstPhrases = poem.firstPhrase.components(separatedBy: " ")
                canvasVM.correctYetWord = canvasVM.currentFirstPhrases[0]
            }
            .environmentObject(SharedVM())
    }
}

extension CanvasPageView {
    // MARK: ContainerView
    
    private func ContainerView() -> some View {
        GeometryReader { geometry in
            
            // MARK: iPadOS
            if geometry.size.width > 834 {
                HStack(spacing: .spacing_medium) {
                    /// ScriptView
                    VStack {
                        Text("Script View")
                    }
                    .whiteBackgroundContainerStyleModifier()
                    .frame(maxWidth: geometry.size.width * 0.3)
                    /// DialView
                    VStack {
                        Text("Dial View")
                    }
                    .whiteBackgroundContainerStyleModifier()
                    .frame(maxWidth: geometry.size.width * 0.7)
                }
                .frame(maxWidth: geometry.size.width)
                .padding(.spacing_medium)
                .background(Color.systemGray6)
            } else {
                // MARK: iOS
                iOSLayoutView()
                ScriptView(
                    canvasVM: canvasVM,
                    poem: poem)
                .frame(maxWidth: .infinity,
                       minHeight: SharedVM.isIOS ? 0 : geometry.size.width * 0.3,
                       maxHeight: canvasVM.isFinished
                       ? .infinity
                       : SharedVM.isIOS
                       ? 0
                       : geometry.size.width * 0.3
                )
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0), value: canvasVM.isFinished)
                .background(Color.systemGray6)
                .cornerRadius(4)
                .zIndex(1)
            }
            
        }
    }
    
    // MARK: iOSLayoutView
    
    private func iOSLayoutView() -> some View {
        VStack(spacing: 0) {
            // MARK: Progress
            
            HStack {
                Image(systemName: "lock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .btn_inner_medium, height: .btn_inner_medium)
                    .foregroundColor(Color(UIColor.label))
                Text("\(canvasVM.correctedFirstPhrases.count) / \(canvasVM.currentFirstPhrases.count)")
            }
            .frame(maxWidth: .infinity, maxHeight: 64)
            
            // MARK: QuizView
            
            VStack {
                DialView(canvasVM: canvasVM)
            }
            .whiteBackgroundContainerStyleModifier()
            .padding(.horizontal, .spacing_medium)
            .padding(.bottom, .spacing_medium)
        }
        .background(Color.systemGray6)
    }
    
    // MARK: ShowPlayRuleButtonView
    
    private func ShowPlayRuleButtonView() -> some View {
        Button {
            self.isShowPopOver = true
        } label: {
            Image(systemName: "questionmark.circle")
                .resizable()
                .scaledToFit()
                .frame(width: .btn_inner_medium, height: .btn_inner_medium)
                .foregroundColor(Color(UIColor.label))
        }
        .frame(width: .btn_outer_medium, height: .btn_outer_medium)
        .sheet(isPresented: $isShowPopOver) {
            PlayDescriptionView()
        }
    }
    
    // MARK: PlayDescriptionView
    
    private func PlayDescriptionView() -> some View {
        VStack {
            ScrollView {
                TextView(
                    content:
                    """
                    How to Play?
                    
                    Please complete the first verse of the locked poem for each question.
                    
                    Each time you complete the first phrase, the unlock counter goes up.
                    
                    1. At the top of the letter, there is a phrase that needs to be matched.
                    
                    
                    2. Drag the letter and send it to the phrase.
                    
                    
                    3. If the current letter matches the letter that needs to be matched, the letter color will change.
                    
                    
                    4. If the current letter does not match the letter you need to match, please change the letter.
                    
                    
                    5. You can change the letters by swiping the dials on the left, right, and bottom of the letters.
                    
                    Good luck.
                    
                    Enjoy Catch a Phrase!
                    
                    
                    Caution! You can compare letters from the beginning.
                    
                    """,
                    language: .En,
                    size: 24
                )
                .foregroundColor(Color(UIColor.label))
                .multilineTextAlignment(.leading)
            }
        }
        .padding(24)
    }
}
