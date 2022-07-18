//
//  SignAPI.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/19.
//

import Alamofire
import Foundation

/*
 ~API: 실제 서버통신을 하기 위해 API를 구현하는 클래스 (BaseAPI를 상속)
 싱글턴으로 접근한다. 앞서 만든 request 함수를 호출하고 Service를 통해 서버통신 수행
 네트워크 결과를 받아와서 처리
 */

class SignAPI: BaseAPI {
    static let shared = SignAPI()
    
    private override init() { }
    
    /// [GET] 소셜 로그인 요청
    func requestLoginAPI(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(SignService.requestKaKaoLogin).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, data, SignInResModel.self)
                completion(networkResult)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
