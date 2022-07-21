//
//  GetRemindGoalListModel.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/21.
//

import Foundation

// MARK: RemindGoalListModel
struct RemindGoalListModel: Codable {
    let id: Int
    let amount: Int
    let content: String
    let startEmotion: Int
    let endEmotion: Int
    let timestamp: String
}
