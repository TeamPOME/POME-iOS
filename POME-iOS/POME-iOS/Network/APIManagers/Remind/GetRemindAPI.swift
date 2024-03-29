//
//  GetRemindAPI.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/21.
//

import Foundation

class GetRemindAPI: BaseAPI {
    static let shared = GetRemindAPI()
    
    private override init() { }
    
    func requestGetRemindGoalAPI(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(RemindService.getGoals).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, [GetRemindGoalModel].self)
                completion(networkResult)
                print(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getRemindGoalListAPI(goalId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(RemindService.getRecords(goalId: goalId, startEmotion: 0, endEmotion: 0)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, [GetRemindGoalListModel].self)
                completion(networkResult)
                print(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
