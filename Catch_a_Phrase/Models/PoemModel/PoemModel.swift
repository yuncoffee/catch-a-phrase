//
//  PoemModel.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/05.
//

import Foundation

struct Poem {
    let id = UUID()
    // 제목 / 내용 / 저자
    var krInfo: (String, String, String)
    var enInfo: (String, String, String)
    var firstPhrase: String
    var thumbChar: String
}
