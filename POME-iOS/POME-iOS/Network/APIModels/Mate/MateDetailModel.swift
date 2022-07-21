//
//  MateDetailModel.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/21.
//

import Foundation

// MARK: MateDetailModel
struct MateDetailModel: Codable {
    let id: Int
    let userId: Int
    let nickname: String
    let profileImage: String
    let goalMessage: String
    let amount: Int
    let content: String
    let startEmotion: Int
    let endEmotion: Int
    let timeStamp: String
    let reactions: [String]
    let plusCount: Int
}
