//
//  GoalStorageModel.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/20.
//

import Foundation

// MARK: GoalStorageResModel
struct GoalStorageResModel: Codable {
    let id: Int
    let message: String
    let amount: Int
    let payAmount: Int
    let rate: Int
    let isPublic: Bool
    let isSuccess: Bool
}
