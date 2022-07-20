//
//  PostGoalResModel.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/21.
//

import Foundation

// MARK: - PostGoalResModel
struct PostGoalResModel: Codable {
    let id: Int
    let category: String
    let message: String
    let amount: Int
    let startDate: String
    let endDate: String
    let isPublic: Bool
}
