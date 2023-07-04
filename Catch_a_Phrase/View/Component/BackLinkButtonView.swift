//
//  BackLinkButtonView.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/26.
//

import SwiftUI

struct BackLinkButtonView: View {
    var completion: ()->()
    
    var body: some View {
        Button {
            completion()
        } label: {
            Image(systemName: "arrow.backward")
        }
        .frame(width: .btn_outer_medium, height: .btn_outer_medium)
        .foregroundColor(.systemGray2)
        .accessibilityLabel("hello")
        
    }
}

struct BackLinkButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackLinkButtonView {
            print("hello")
        }
    }
}
