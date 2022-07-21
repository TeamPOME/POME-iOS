//
//  GoalStorageService.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/20.
//

import Foundation
import Alamofire

enum GoalStorageService {
    case requestGoalStorage
    case requestDeleteGoal(goalId: Int)
}

extension GoalStorageService: TargetType {
    
    var path: String {
        switch self {
        case .requestGoalStorage:
            return "/goals/storage"
        case .requestDeleteGoal(let goalId):
            return "/goals/\(goalId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .requestGoalStorage:
            return .get
        case .requestDeleteGoal:
            return .delete
        }
    }
    var parameters: RequestParams {
        switch self {
        case .requestGoalStorage:
            return .requestPlain
        case .requestDeleteGoal(let goalId):
            let requestQuery : [String : Any] = [
                "goalId" : goalId
            ]
            return .query(requestQuery)
        }
    }
    
    var header: HeaderType {
        switch self {
        case .requestGoalStorage, .requestDeleteGoal:
            return .auth
        }
    }
}

