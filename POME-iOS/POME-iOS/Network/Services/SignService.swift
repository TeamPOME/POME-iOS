//
//  SignService.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/18.
//

import Alamofire
import UIKit

/*
 AuthRouter : 여러 Endpoint들을 갖고 있는 enum
 TargetType을 채택해서 path, method, header, parameter를 각 라우터에 맞게 request를 만든다.
 */

enum SignService {
    case requestKakaoLogin
    case searchMate(nickname: String)
    case addMate(targetID: Int)
}

extension SignService: TargetType {
    
    var path: String {
        switch self {
        case .requestKakaoLogin:
            return "/auth/kakao"
        case .searchMate(_):
            return "/friends/search"
        case .addMate:
            return "/friends"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            
        case .requestKakaoLogin, .searchMate:
            return .get
        case .addMate:
            return .post
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .requestKakaoLogin:
            return .requestPlain
        case .searchMate(let nickname):
            let requestQuery: [String: Any] = [
                "nickname": nickname
            ]
            return .query(requestQuery)
        case .addMate(let targetID):
            let body: [String: Any] = [
                "targetId": targetID
            ]
            return .requestBody(body)
        }
    }
    
    var header: HeaderType {
        switch self {
        case .requestKakaoLogin:
            return .kakaoAuth
        case .searchMate, .addMate:
            return .auth
        }
    }
}
