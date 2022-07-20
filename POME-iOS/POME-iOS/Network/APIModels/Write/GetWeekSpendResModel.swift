//
//  GetWeekSpendResModel.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/21.
//

import Foundation

// MARK: - GetWeekSpendResModel
struct GetWeekSpendResModel: Codable {
    let incompleteTotal: Int
    let records: [Record]
}

// MARK: - Record
struct Record: Codable {
    let date: String
    let amount: Int
    let content: String
    let startEmotion: Int
    let endEmotion: Int
}
