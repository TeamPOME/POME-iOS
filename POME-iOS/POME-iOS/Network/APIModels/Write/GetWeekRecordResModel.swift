//
//  GetWeekSpendResModel.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/21.
//

import Foundation

// MARK: - GetWeekRecordResModel
struct GetWeekRecordResModel: Codable {
    let incompleteTotal: Int
    let records: [Record]
}

// MARK: - Record
struct Record: Codable {
    let id: Int
    let date: String
    let amount: Int
    let content: String
    let startEmotion: Int
    let endEmotion: Int
}
