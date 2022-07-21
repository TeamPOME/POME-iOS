//
//  EmojiList.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/21.
//

import Foundation
import UIKit

/**
 받은 이모지 넘버를 가지고 에셋 이름을 매칭한다.
 
 사용방법
 - 처음 감정: NumToEmoji.first(num: 서버에서 넘어온 처음 감정 이모지 넘버)
 - 나중 감정: 기록탭 메인이 아닐 때 -> NumToEmoji.second(num: 서버에서 넘어온 나중 감정 이모지 넘버)
          기록탭 메인일 때 -> NumToEmoji.second(num: 서버에서 넘어온 나중 감정 이모지 넘버,isWriteVC: true)
 */
struct NumToEmoji {
    static func first(num: Int) -> UIImage? {
        switch num {
        case 1:
            return UIImage(named: "property1IcHeartMint")
        case 2:
            return UIImage(named: "property1IcWhatMint")
        case 3:
            return UIImage(named: "property1IcSadMint")
        default:
            return UIImage(named: "btnEmojiPlus38")
        }
    }
    
    static func second(num: Int, isWriteVC: Bool = false) -> UIImage? {
        switch num {
        case 1:
            return UIImage(named: "property1EmojiHappyPink")
        case 2:
            return UIImage(named: "property1EmojiWhatPink")
        case 3:
            return UIImage(named: "property1EmojiSadPink")
        default:
            return isWriteVC ? UIImage(named: "btnEmojiQuestion38") : UIImage(named: "btnEmojiPlus38")
        }
    }
}

struct EmojiToNum {
    static let happy = 1
    static let dontKnow = 2
    static let regret = 3
}
