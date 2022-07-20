//
//  UserDefaults+.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/07.
//

import Foundation

extension UserDefaults {
    
    /// UserDefaults key value가 많아지면 관리하기 어려워지므로 enum 'Keys'로 묶어 관리합니다.
    enum Keys {
        
        /// String
        static var accessToken = "accessToken"
        
        /// String
        static var refreshToken = "refreshToken"
        
        /// String
        static var uuid = "uuid"
        
        /// Int
        static var userID = "userID"
    }
}
