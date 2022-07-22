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
    
    /// [GET] 목표 카테고리 조회 API
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
    
    /// [GET] 목표 상세 조회 API
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
    
    /// [DEETE] 목표 삭제 API
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
    
    /// [POST] 목표 추가 API
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
    
    /// [GET] 일주일 씀씀이 조회 API
    func getWeekSpendAPI(goalId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(WriteService.getWeekSpend(goalId: goalId)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, GetWeekSpendResModel.self)
                completion(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    /// [POST] 씀씀이 추가 API
    func postRecordAPI(goalId: Int, date: String, amount: Int, content: String, startEmotion: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(WriteService.postRecord(goalId: goalId, date: date, amount: amount, content: content, startEmotion: startEmotion)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, PostRecordResModel.self)
                completion(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}