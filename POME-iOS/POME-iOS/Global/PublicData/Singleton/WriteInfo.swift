//
//  WriteInfo.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/22.
//

import Foundation

class WriteInfo {
    static let shared = WriteInfo()

    var index: Int = 1
    
    private init() { }
}
