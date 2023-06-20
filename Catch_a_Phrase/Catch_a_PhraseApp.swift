//
//  Catch_a_PhraseApp.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/05/22.
//

import SwiftUI

@main
struct Catch_a_PhraseApp: App {
    let persistenceController = PersistenceController.shared

    init() {
//        CustomFont.registerFonts(fontName: "NanumMyeongjo-YetHangul")
//        CustomFont.registerFonts(fontName: "LibreBaskerville-Regular")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
