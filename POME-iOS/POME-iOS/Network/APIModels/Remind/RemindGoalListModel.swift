//
//  GetRemindGoalListModel.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/21.
//

import Foundation

/// 해당 카테고리에 대한 목표 리스트 조회
struct RemindGoalListModel: Codable {
    let goalMessage: String
    let isGoalPublic: Bool
    let amount: Int
    let content: String
    let startEmotion, endEmotion: Int
    let timestamp: String
}
