//
//  GetMateService.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/20.
//

import Foundation
import Alamofire

enum MateService {
    case getMate
    case getMateRecord(userId: Int)
}

extension MateService: TargetType {
    
    var header: HeaderType {
        switch self {
        case .getMate, .getMateRecord:
            return .auth
        }
    }
    
    var path: String {
        switch self {
        case .getMate:
            return "/friends"
        case .getMateRecord(_):
            return "/friends/records"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMate, .getMateRecord:
            return .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getMate:
            return .requestPlain
        case .getMateRecord(let mateId):
            let requestQuery: [String: Any] = [
                "userId": mateId
            ]
            return .query(requestQuery)
        }
    }
}
