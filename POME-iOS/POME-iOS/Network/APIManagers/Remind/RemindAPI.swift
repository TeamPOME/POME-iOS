//
//  GetRemindAPI.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/21.
//

import Foundation

class RemindAPI: BaseAPI {
    static let shared = RemindAPI()
    
    private override init() { }
    
    /// [GET] 목표 카테고리 조회 API
    func requestGetRemindGoalAPI(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(RemindService.getGoals).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, [RemindGoalModel].self)
                completion(networkResult)
                print(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [GET] 감정별 기록 조회 API 
    func requestGetRemindGoalListAPI(goalId: Int, startEmotion: Int, endEmotion: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(RemindService.getRecords(goalId: goalId, startEmotion: startEmotion, endEmotion: endEmotion)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, [RemindGoalListModel].self)
                completion(networkResult)
                print(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
