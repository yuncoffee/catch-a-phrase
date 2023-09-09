//
//  ScriptView.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/09/09.
//

import SwiftUI

struct ScriptView: View {
    @Environment(\.presentationMode)
    var presentationMode
    
    @EnvironmentObject var sharedVM: SharedVM
    
    @ObservedObject var canvasVM: CanvasVM
    
    var poem: Poem
    
    @State
    private var scrollOffset = CGPoint()
    
    @State
    private var baseScrollOffset = 0.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            if !SharedVM.isIOS {
                ScriptHeaderView
            }
            PoemScriptView
            ScriptFooterView
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .padding(16)
    }
}

extension ScriptView {
    // MARK: ScriptHeaderView
    private var ScriptHeaderView: some View {
        HStack(alignment: .top) {
            BackLinkButtonView {
                presentationMode.wrappedValue.dismiss()
                canvasVM.resetDialStatus()
                
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
    }
    
    // MARK: PoemScriptView
    private var PoemScriptView: some View {
        
        return ZStack(alignment: .bottomLeading) {
            OffsetObservingScrollView(offset: $scrollOffset, length: $baseScrollOffset) {
                TextView(
                    content: sharedVM.isLanguageKr ? poem.krInfo.1 : poem.enInfo.1,
                    language: sharedVM.isLanguageKr ? .Kr : .En,
                    size: 24
                )
//                .foregroundColor(
//                    canvasVM.isFinished
//                    ? .systemBlack
//                    : .systemGray3)
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            GradientBoxView()
                .opacity(canvasVM.isFinished ? 0 : 1)
            VStack {
                Image(systemName: "lock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
                    .foregroundColor(.systemBlack)
                Text("\(canvasVM.correctedFirstPhrases.count) / \(canvasVM.currentFirstPhrases.count)")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .opacity(canvasVM.isFinished ? 0 : 1)
        }
        .frame(alignment: .bottomLeading)
    }
    
    // MARK: PoemDetailInfoView
    private var PoemDetailInfoView: some View {
        TextView(content: sharedVM.isLanguageKr
                 ? "\(poem.krInfo.0) (\(poem.krInfo.2))"
                 : "\(poem.enInfo.0) (\(poem.enInfo.2))",
                 language: sharedVM.isLanguageKr ? .Kr : .En,
                 size: 18)
//        .foregroundColor(.systemBlack)
    }
    
    private var ScriptFooterView: some View {
        let iOS = SharedVM.isIOS
        return HStack(alignment: .center) {
            PoemDetailInfoView
            Spacer()
            HStack {
                Button {
                    sharedVM.toggleLanguage()
                } label: {
                    Image(systemName: "globe")
                        .foregroundColor(.systemBlack)
                }
                .frame(width: 40, height: 40)
                .background(Color.siri_btn)
                .cornerRadius(50)
                Button {
                    if canvasVM.isSiriSpeaking {
                        canvasVM.stopReadContentToSiri()
                    } else {
                        if sharedVM.isLanguageKr {
                            canvasVM.readContentToSiri(contents: poem.krInfo.1, nil)
                        } else {
                            canvasVM.readContentToSiri(contents: poem.enInfo.1, "en-US")
                        }
                    }
                    
                } label: {
                    Image(systemName: "play.fill")
                        .foregroundColor(.systemBlack)
                }
                .frame(width: 40, height: 40)
                .background(Color.siri_btn)
                .cornerRadius(50)
            }
            
        }
        .frame(maxWidth: .infinity, minHeight: iOS ? 0 : 48, alignment: .trailing)
//        .opacity(canvasVM.isFinished ? 1 : 0)
    }
}

// struct ScriptView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScriptView()
//    }
// }
