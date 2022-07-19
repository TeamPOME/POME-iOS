//
//  WriteService.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/20.
//

import Alamofire
import Foundation

enum WriteService {
    case getGoalGategory
    case getGoalDetail(goalId: Int)
}

extension WriteService: TargetType {
    
    var path: String {
        switch self {
        case .getGoalGategory:
            return "/goals"
        case .getGoalDetail(let goalId):
            return "/goals/\(goalId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getGoalGategory, .getGoalDetail:
            return .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getGoalGategory:
            return .requestPlain
        case .getGoalDetail(let goalId):
            let requestQuery: [String: Any] = [
                "goalId": goalId
            ]
            return .query(requestQuery)
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getGoalGategory, .getGoalDetail:
            return .auth
        }
    }
}
