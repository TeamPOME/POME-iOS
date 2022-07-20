//
//  RemindService.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/21.
//

import Foundation
import Alamofire

enum RemindService {
    case getGoals
    case getRecords(goalId: Int, startEmotion: Int, endEmotion: Int)
}

extension RemindService: TargetType {
    var header: HeaderType {
        switch self {
        case .getGoals, .getRecords:
            return .auth
        }
    }
    
    var path: String {
        switch self {
        case .getGoals:
            return "/goals"
        case .getRecords:
            return "/records"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getGoals, .getRecords:
            return .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getGoals:
            return .requestPlain
        case .getRecords(let goalId, let startEmotion, let endEmotion):
            let requestQuery: [String: Any] = [
                "goalId": goalId,
                "startEmotion": startEmotion,
                "endEmotion": endEmotion
            ]
            return .query(requestQuery)
        }
    }
}
