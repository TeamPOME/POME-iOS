//
//  GetGoalDetailResModel.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/20.
//

import Foundation

// MARK: GetGoalDetailResModel
struct GetGoalDetailResModel: Codable {
    let id: Int
    let message: String
    let amount: Int
    let payAmount: Int
    let rate: Int
    let isPublic: Bool
    let dDay: Int
}
