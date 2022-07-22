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
    case postMateEmoji(emotion: Int, targetId: Int)
}

extension MateService: TargetType {
    
    var path: String {
        switch self {
        case .getMate:
            return "/friends"
        case .getMateRecord(_):
            return "/friends/records"
        case .postMateEmoji:
            return "records/reaction"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMate, .getMateRecord:
            return .get
        case .postMateEmoji:
            return .post
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
        case .postMateEmoji(let emotion, let targetId):
            let body: [String: Any] = [
                "emotion": emotion,
                "targetId": targetId
            ]
            return .requestBody(body)
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getMate, .getMateRecord, .postMateEmoji:
            return .auth
        }
    }
}
