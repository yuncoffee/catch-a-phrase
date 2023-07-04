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

    @State
    private var isShowCanvas = false

    var body: some View {
        ContainerView()
            .navigationTitle("Stage")
    }
}

extension StageListPageView {
    // MARK: ContainerView

    private func ContainerView() -> some View {
        let outterPadding = .spacing_medium * 2
        let innerPadding = .spacing_medium * 4
        let iPadOSBoxSize: CGFloat = 240

        return GeometryReader { geo in
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    GradientBoxView()
                        .frame(maxWidth: .infinity, maxHeight: .spacing_medium)
                        .rotationEffect(Angle.degrees(180))
                        .offset(y: .spacing_medium)
                        .zIndex(1)
                    ScrollView {
                        VStack {
                            StageListView(
                                size: SharedVM.isIOS
                                    ? geo.size.width - innerPadding
                                    : iPadOSBoxSize)
                        }
                        .padding(.vertical, .spacing_medium)
                        .frame(minHeight: geo.size.height - innerPadding)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    GradientBoxView()
                        .frame(maxWidth: .infinity, maxHeight: .spacing_medium)
                        .offset(y: -.spacing_medium)
                }
                .frame(
                    maxWidth: .infinity - outterPadding,
                    maxHeight: .infinity,
                    alignment: .center
                )
            }
            .whiteBackgroundContainerStyleModifier()
            .padding(.spacing_medium)
            .background(Color.systemGray6)
        }
    }

    // MARK: BackLinkButtonView

    private func _BackLinkButtonView(completion: @escaping () -> Void) -> some View {
        BackLinkButtonView {
            completion()
        }
    }

    // MARK: StageListView

    private func StageListView(size: CGFloat) -> some View {
        let iOSGridItem = [GridItem(.fixed(size), spacing: .spacing_medium)]
        let iPadOSGridItem = [
            GridItem(.fixed(240), spacing: .spacing_medium),
            GridItem(.fixed(240), spacing: .spacing_medium),
        ]

        return LazyVGrid(
            columns: SharedVM.isIOS ? iOSGridItem : iPadOSGridItem,
            alignment: .center, spacing: .spacing_medium
        ) {
            ForEach(0 ..< 4) { _ in
                NavigationLink {
                    CanvasPageView()
                } label: {
                    ZStack {
                        GraphPaperView(size: size)
                            .frame(minHeight: size)
                        TextView(content: "가", size: 120)
                            .foregroundColor(Color(UIColor.label))
                    }
                }
            }
        }
    }
}

struct StageListPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
                //            StageListPageView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
