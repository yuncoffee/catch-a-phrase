//
//  DialVM.swift
//  Catch_a_Phrase
//
//  Created by Yun Dongbeom on 2023/06/27.
//

import Foundation
import AVFoundation

class DialVM: ObservableObject {
    private let DIAL_LIMIT_ANGLE: CGFloat = 32
    private let KR_CHARS_MAX_LIST = [18, 20, 27] // 초성, 중성, 종성
    
    @Published
    var isShowAnimation = false {
        didSet {
            if isShowAnimation {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    self.isShowAnimation = false
                }
            }
        }
    }
    
    /// 다이얼이 돌아간 값을 저장하기 위한 값
    @Published
    var totalRotates = [CGSize.zero, CGSize.zero, CGSize.zero] {
        didSet {
            // 왼쪽 초성 다이얼
            if prevRotates[0].height + DIAL_LIMIT_ANGLE < totalRotates[0].height {
                prevRotates[0] = totalRotates[0]
                krScalers[0] += 1
            }
            if prevRotates[0].height - DIAL_LIMIT_ANGLE > totalRotates[0].height {
                prevRotates[0] = totalRotates[0]
                krScalers[0] -= 1
            }
            // 오른쪽 중성 다이얼
            if prevRotates[1].height + DIAL_LIMIT_ANGLE < totalRotates[1].height {
                prevRotates[1] = totalRotates[1]
                krScalers[1] += 1
            }
            if prevRotates[1].height - DIAL_LIMIT_ANGLE > totalRotates[1].height {
                prevRotates[1] = totalRotates[1]
                krScalers[1] -= 1
            }
            // 아래쪽 종성 다이얼
            if prevRotates[2].width + DIAL_LIMIT_ANGLE < totalRotates[2].width {
                prevRotates[2] = totalRotates[2]
                krScalers[2] -= 1
            }
            if prevRotates[2].width - DIAL_LIMIT_ANGLE > totalRotates[2].width {
                prevRotates[2] = totalRotates[2]
                krScalers[2] += 1
            }
        }
    }
    
    @Published
    var prevRotates = [CGSize.zero, CGSize.zero, CGSize.zero] {
        didSet {
//            HapticManager.shared.impact(type: .rigid)
//            HapticStruct.impact(type: .rigid)
//            HapticEnum.alarm.impact(type: .rigid)
            HapticEnum.impact(type: .rigid)
//            HapticStaticClass.impact(type: .rigid)
            AudioServicesPlaySystemSoundWithCompletion(1157, nil)
        }
    }
    
    @Published
    var currentRotates = [CGSize.zero, CGSize.zero, CGSize.zero]
    
    /// 초성: 18자,
    /// 중성: 20자,
    /// 종성: 27자
    @Published
    var krScalers = [0, 0, 0] {
        didSet {
            if krScalers[0] < 0 {
                krScalers[0] = KR_CHARS_MAX_LIST[0]
            } else if krScalers[0] > KR_CHARS_MAX_LIST[0] {
                krScalers[0] = 0
            }
            if krScalers[1] < 0 {
                krScalers[1] = KR_CHARS_MAX_LIST[1]
            } else if krScalers[1] > KR_CHARS_MAX_LIST[1] {
                krScalers[1] = 0
            }
            if krScalers[2] < 0 {
                krScalers[2] = KR_CHARS_MAX_LIST[2]
            } else if krScalers[2] > KR_CHARS_MAX_LIST[2] {
                krScalers[2] = 0
            }
        }
    }
}

extension DialVM {
//    func updateCurrentCharcter(globalStore: GlobalStore) {
//        if let firstScaler = Unicode.Scalar(0x1100 + krScalers[0]),
//           let secondaryScaler = Unicode.Scalar(0x1161 + krScalers[1]),
//           let thirdScaler = Unicode.Scalar(0x11a6 + 1 + krScalers[2])
//        {
//            let char = krScalers[2] == 0
//            ? String(firstScaler).appending(String(secondaryScaler))
//            : String(firstScaler).appending(String(secondaryScaler)).appending(String(thirdScaler))
//
//            globalStore.currentCharcter = char
//
//            if globalStore.currentCharcter.count > 0 && globalStore.correctYetWord.count > 0 &&   globalStore.currentCharcter[globalStore.currentCharcter.startIndex] == globalStore.correctYetWord[globalStore.correctYetWord.startIndex] {
//                isShowAnimation = true
//            } else {
//                isShowAnimation = false
//            }
//        }
//    }
}
