//
//  UserResModel.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/22.
//

import Foundation

// MARK: UserResModel
struct UserResModel: Codable {
    let nickname: String
    let profileImage: String
    let marshmallows: Marshmallows
    let goalStorageCount: Int
}

// MARK: - Marshmallows
struct Marshmallows: Codable {
    let recordLevel, reactLevel, growLevel, frankLevel: Int
}
