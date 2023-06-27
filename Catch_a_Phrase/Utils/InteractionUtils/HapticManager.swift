//
//  HapticManager.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/27.
//

import Foundation
import UIKit

class HapticManager {
    static let shared = HapticManager()
    
    private init() {}
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(type: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: type)
        generator.impactOccurred()
    }
    
}
