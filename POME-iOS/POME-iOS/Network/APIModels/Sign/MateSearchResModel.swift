//
//  MateSearchResModel.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/21.
//

import Foundation

// MARK: MateSearchResModel
struct MateSearchResModel: Codable {
    let id: Int
    let nickname: String
    let profileImage: String
    var isFriend: Bool
}
