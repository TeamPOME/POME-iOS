//
//  GetIncompleteRecordResModel.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/23.
//

import Foundation

// MARK: - GetIncompleteRecordResModel
struct GetIncompleteRecordResModel: Codable {
    let total: Int
    let records: [Record]
}
