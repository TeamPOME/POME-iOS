//
//  SignUpResModel.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/19.
//

import Foundation

// MARK: SignUpResModel
struct SignUpResModel: Codable {
    let id: Int
    let nickname: String
    let accessToken: String
    let refreshToken: String
}
