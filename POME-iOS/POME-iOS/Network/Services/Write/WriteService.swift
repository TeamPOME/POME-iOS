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
    case getWeekSpend(goalId: Int)
    case postRecord(goalId: Int, date: String, amount: Int, content: String, startEmotion: Int)
}

extension WriteService: TargetType {
    
    var path: String {
        switch self {
        case .getGoalGategory, .postGoal:
            return "/goals"
        case .getGoalDetail(let goalId), .deleteGoal(let goalId):
            return "/goals/\(goalId)"
        case .getWeekSpend(let goalId):
            return "/records/week/\(goalId)"
        case .postRecord:
            return "/records"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getGoalGategory, .getGoalDetail, .getWeekSpend:
            return .get
        case .deleteGoal:
            return .delete
        case .postGoal, .postRecord:
            return .post
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getGoalGategory:
            return .requestPlain
        case .getGoalDetail(let goalId), .deleteGoal(let goalId), .getWeekSpend(let goalId):
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
        case .postRecord(let goalId, let date, let amount, let content, let startEmotion):
            let requestBody: [String: Any] = [
                "goalId": goalId,
                "date": date,
                "amount": amount,
                "content": content,
                "startEmotion": startEmotion
            ]
            return .requestBody(requestBody)
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getGoalGategory, .getGoalDetail, .deleteGoal, .postGoal, .getWeekSpend, .postRecord:
            return .auth
        }
    }
}