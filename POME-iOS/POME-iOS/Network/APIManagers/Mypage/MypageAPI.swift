//
//  GoalStorageAPI.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/20.
//

import Foundation

class MypageAPI: BaseAPI {
    static let shared = MypageAPI()
    
    private override init() { }
    
    /// [GET] 목표 저장 조회
    func requestGoalStorage(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MypageService.requestGoalStorage).responseData { response in
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
    func requestDeleteGoal(goalId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MypageService.requestDeleteGoal(goalId: goalId)).responseData { response in
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
    
    /// [GET] 유저 정보 가져오기
    func requestUser(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MypageService.requestUser).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, UserResModel.self)
                completion(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
