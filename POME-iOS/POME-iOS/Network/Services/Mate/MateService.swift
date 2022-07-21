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
}

extension MateService: TargetType {
    
    var header: HeaderType {
        switch self {
        case .getMate:
            return .auth
        }
    }
    
    var path: String {
        switch self {
        case .getMate:
            return "/friends"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMate:
            return .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getMate:
            return .requestPlain
        }
    }
}
