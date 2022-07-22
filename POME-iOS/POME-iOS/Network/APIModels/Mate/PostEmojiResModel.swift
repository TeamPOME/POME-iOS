//
//  PostEmojiResModel.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/23.
//

import Foundation

// MARK: - PostEmojiResModel
struct PostEmojiResModel: Codable {
    let reactions: [Int]
    let plusCount: Int
}
