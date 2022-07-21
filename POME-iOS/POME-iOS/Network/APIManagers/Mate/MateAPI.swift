//
//  GetMateAPI.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/20.
//

import Foundation

class MateAPI: BaseAPI {
    static let shared = MateAPI()
    
    private override init() { }
    
    /// [GET] 친구 전체조회 API
    func requestGetMateAPI(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(MateService.getMate).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, [MateResModel].self)
                completion(networkResult)
                print(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
