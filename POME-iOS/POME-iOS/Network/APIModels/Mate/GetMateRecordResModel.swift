//
//  GetMateRecordResModel.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/22.
//

import Foundation

// MARK: - GetMateRecordResModel
struct GetMateRecordResModel: Codable {
    let id: Int
    let userID: Int
    let nickname: String
    let profileImage: String
    let goalMessage: String
    let amount: Int
    let content: String
    let startEmotion: Int
    let endEmotion: Int
    let timestamp: String
    let reactions: [Int]
    let plusCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case nickname, profileImage, goalMessage, amount, content, startEmotion, endEmotion, timestamp, reactions, plusCount
    }
}
