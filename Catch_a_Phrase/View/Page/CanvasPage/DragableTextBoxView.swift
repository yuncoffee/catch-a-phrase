//
//  DragableTextBoxView.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/09/09.
//

import SwiftUI

struct DragableTextBoxView: View {
    @ObservedObject var canvasVM: CanvasVM
    
    @Binding
    var krScalers: [Int]
    
    @State
    private
    var draggedOffset = CGSize.zero
    
    @State
    private var translationY = 0.0 {
        didSet {
            let ios = SharedVM.isIOS
            let offset: Double = ios ? -240 : -320
            if translationY < offset {
                isSubmitAble = true
            }
        }
    }
    
    @State
    private var isSubmitAble = false
    
    var body: some View {
        let ios = SharedVM.isIOS
        
        ZStack {
            GraphPaperView(size: 240)
                .frame(minHeight: 240)
            TextView(content: canvasVM.currentCharcter,
                     size: draggedOffset.height < -100 ? 64 : 160)
                .offset(draggedOffset)
                .gesture(drag)
                .animation(.easeIn(duration: 0.1), value: draggedOffset)
                .opacity(isSubmitAble ? 0 : 1)
                .foregroundColor(Color(UIColor.label))
//            GraphPaperView(size: SharedVM.isIOS ? 240 : 320)
//                .frame(minHeight: SharedVM.isIOS ? 240 : 320)
//            TextView(content: canvasVM.currentCharcter,
//                     size: draggedOffset.height < -100 ? 64 : ios ? 160 : 200)
//                .offset(draggedOffset)
//                .gesture(drag)
//                .animation(.easeIn(duration: 0.1), value: draggedOffset)
//                .opacity(isSubmitAble ? 0 : 1)
//                .foregroundColor(Color(UIColor.label))
            ReadCurrentCharView
            
        }.frame(width: 320, height: 320)
    }
}

// MARK: Views
extension DragableTextBoxView {
    
    // MARK: ReadCurrentCharView
    private var ReadCurrentCharView: some View {
        let ios = SharedVM.isIOS
        
        return Button {
            canvasVM.readContentToSiri(contents: canvasVM.currentCharcter, nil)
        } label: {
            Image(systemName: "play.fill")
                .foregroundColor(.systemBlack)
            
        }
        .frame(width: 40, height: 40)
        .background(Color.siri_btn)
        .cornerRadius(50)
//        .position(x: ios ? 260 - 12 : 300 - 12, y: ios ? 260 - 12 : 300 - 12)
        .position(x: 260 - 12, y: 260 - 12)
    }
}

// MARK: Gesture
extension DragableTextBoxView {
    private var drag: some Gesture {
      DragGesture()
        .onChanged { gesture in
            translationY = gesture.translation.height
            draggedOffset = gesture.translation
        }
        .onEnded { _ in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0)) {
                if isSubmitAble {
                    canvasVM.compareTitleWithWord()
                    krScalers = [0, 0, 0]
                }
                draggedOffset = .zero
                translationY = .zero
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    isSubmitAble = false
                }
            }
        }
    }
}
