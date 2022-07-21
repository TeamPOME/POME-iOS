//
//  PostSpendResModel.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/22.
//

import Foundation

// MARK: - PostRecordResModel
struct PostRecordResModel: Codable {
    let id: Int
    let date: String
    let amount: Int
    let content: String
    let startEmotion: Int
}
