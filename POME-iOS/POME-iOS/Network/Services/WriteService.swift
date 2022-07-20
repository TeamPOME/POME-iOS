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
    case postGoal(startDate: String, endDate: String, category: String, message: String, amount: Int, isPublic: Bool)
    case deleteGoal(goalId: Int)
}

extension WriteService: TargetType {
    
    var path: String {
        switch self {
        case .getGoalGategory, .postGoal:
            return "/goals"
        case .getGoalDetail(let goalId), .deleteGoal(let goalId):
            return "/goals/\(goalId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getGoalGategory, .getGoalDetail:
            return .get
        case .deleteGoal:
            return .delete
        case .postGoal:
            return .post
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getGoalGategory:
            return .requestPlain
        case .getGoalDetail(let goalId), .deleteGoal(let goalId):
            let requestQuery: [String: Any] = [
                "goalId": goalId
            ]
            return .query(requestQuery)
        case .postGoal(let startDate, let endDate, let category, let message, let amount, let isPublic):
            let requestBody: [String: Any] = [
                "startDate": startDate,
                "endDate": endDate,
                "category": category,
                "message": message,
                "amount": amount,
                "isPublic": isPublic
            ]
            return .requestBody(requestBody)
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getGoalGategory, .getGoalDetail, .deleteGoal:
            return .auth
        }
    }
}
