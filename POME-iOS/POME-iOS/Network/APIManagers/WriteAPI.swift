//
//  WriteAPI.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/20.
//

import Alamofire
import Foundation

class WriteAPI: BaseAPI {
    static let shared = WriteAPI()
    
    private override init() { }
    
    /// [GET] 목표 카테고리 조회
    func getGoalsAPI(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(WriteService.getGoalGategory).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, [GetGoalsResModel].self)
                completion(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 목표 상세 조회
    func getGoalDetailAPI(goalId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(WriteService.getGoalDetail(goalId: goalId)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, GetGoalDetailResModel.self)
                completion(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [DEETE] 목표 삭제
    func deleteGoalAPI(goalId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(WriteService.deleteGoal(goalId: goalId)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, EmptyResModel.self)
                completion(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [POST] 목표 추가
    func postGoalAPI(startDate: String, endDate: String, category: String, message: String, amount: Int, isPublic: Bool, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(WriteService.postGoal(startDate: startDate, endDate: endDate, category: category, message: message, amount: amount, isPublic: isPublic)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, PostGoalResModel.self)
                completion(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
