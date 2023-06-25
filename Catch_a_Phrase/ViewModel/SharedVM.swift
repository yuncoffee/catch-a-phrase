//
//  SharedVM.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/26.
//

import Foundation
import UIKit

class SharedVM: ObservableObject {
    static let isIOS = UIDevice.current.systemName == "iOS"
}
