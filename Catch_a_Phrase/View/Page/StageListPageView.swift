//
//  StageListPageView.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/26.
//

import SwiftUI

struct StageListPageView: View {
    @Environment(\.presentationMode)
    private var presentationMode
    
    var body: some View {
        ContainerView()
            .navigationTitle("Stage")
    }
}

extension StageListPageView {
    
    private func ContainerView() -> some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    GradientBoxView()
                        .frame(maxWidth: .infinity, maxHeight: 24)
                        .rotationEffect(Angle.degrees(180))
                        .offset(y: 24)
                        .zIndex(1)
                    ScrollView() {
                        VStack {
                            StageListView(size: geo.size.width - 96)
                        }
                        .padding(.vertical, 24)
                        .frame(minHeight: geo.size.height - 96)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    GradientBoxView()
                        .frame(maxWidth: .infinity, maxHeight: 24)
                        .offset(y: -24)
                }
                .frame(maxWidth: .infinity - 48, maxHeight: .infinity, alignment: .center)
            }
            .background(Color.systemWhite)
            .cornerRadius(16)
            .padding(24)
            .background(Color.systemGray6)
        }
    }
    
    private func _BackLinkButtonView(completion: @escaping()->()) -> some View {
        BackLinkButtonView {
            completion()
        }
    }
    
    private func StageListView(size: CGFloat) -> some View {
        let iOSGridItem = [GridItem(.fixed(320), spacing: 24)]
        let iPadOSGridItem = [
            GridItem(.fixed(240), spacing: 24),
            GridItem(.fixed(240), spacing: 24)
        ]
        
        return LazyVGrid(columns: SharedVM.isIOS ? iOSGridItem : iPadOSGridItem, alignment: .center, spacing: 24) {
            ForEach(0..<4) { index in
                ZStack {
                    GraphPaperView(size: size)
                        .frame(minHeight: size)
                    TextView(content: "가", size: 120)
                }
            }
        }
    }
}

struct StageListPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            //            ContentView()
            StageListPageView()
        }
    }
}
