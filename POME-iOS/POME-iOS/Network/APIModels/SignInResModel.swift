//
//  SignInResModel.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/18.
//

import Foundation

// MARK: SignInResModel
struct SignInResModel: Codable {
    let type: String
    let id: Int?
    let accessToken: String?
    let refreshToken: String?
    let social: String?
    let uuid: String?
}
