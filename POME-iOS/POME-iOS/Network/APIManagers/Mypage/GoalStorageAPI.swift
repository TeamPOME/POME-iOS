//
//  GoalStorageAPI.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/20.
//

import Foundation

class GoalStorageAPI: BaseAPI {
    static let shared = GoalStorageAPI()
    
    private override init() { }
    
    /// [GET] 목표 저장 조회
    func requestGoalStorageAPI(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(GoalStorageService.requestGoalStorage).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, [GoalStorageResModel].self)
                completion(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [DELETE] 목표 삭제
    func requestDeleteGoalAPI(goalId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(GoalStorageService.requestDeleteGoal(goalId: goalId)).responseData { response in
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
}
