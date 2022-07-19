//
//  SignService.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/18.
//

import Alamofire
import Foundation

/*
 AuthRouter : 여러 Endpoint들을 갖고 있는 enum
 TargetType을 채택해서 path, method, header, parameter를 각 라우터에 맞게 request를 만든다.
 */

enum SignService {
    case requestKaKaoLogin
}

extension SignService: TargetType {
    
    var path: String {
        switch self {
        case .requestKaKaoLogin:
            return "/auth/kakao"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            
        case .requestKaKaoLogin:
            return .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .requestKaKaoLogin:
            return .requestPlain
        }
    }
    
    var header: HeaderType {
        switch self {
        case .requestKaKaoLogin:
            return .auth
        }
    }
}
