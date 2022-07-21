//
//  GetRemindGoalListModel.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/21.
//

import Foundation

// MARK: RemindGoalListModel
struct RemindGoalListModel: Codable {
    let goalMessage: String
    let isGoalPublic: Bool
    let amount: Int
    let content: String
    let startEmotion, endEmotion: Int
    let timestamp: String
}
