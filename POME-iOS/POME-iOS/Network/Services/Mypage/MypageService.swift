//
//  GoalStorageService.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/20.
//

import Foundation
import Alamofire

enum MypageService {
    case requestGoalStorage
    case requestDeleteGoal(goalId: Int)
    case requestUser
}

extension MypageService: TargetType {
    
    var path: String {
        switch self {
        case .requestGoalStorage:
            return "/goals/storage"
        case .requestDeleteGoal(let goalId):
            return "/goals/\(goalId)"
        case .requestUser:
            return "/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .requestGoalStorage, .requestUser:
            return .get
        case .requestDeleteGoal:
            return .delete
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .requestGoalStorage, .requestUser:
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
        case .requestGoalStorage, .requestDeleteGoal, .requestUser:
            return .auth
        }
    }
}

