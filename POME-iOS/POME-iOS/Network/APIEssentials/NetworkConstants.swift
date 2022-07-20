//
//  NetworkConstants.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/07.
//

import Foundation
import Alamofire

/*
 NetworkConstants : 서버통신과정에서 필요한 상수들을 관리 -> header 관련 상수들
 */

enum HeaderType {
    case basic
    case auth
    case kakaoAuth
    case multiPart
    case multiPartWithAuth
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case accesstoken = "Authorization"
    case kakaoToken = "token"
}

enum ContentType: String {
    case json = "application/json"
    case multiPart = "multipart/form-data"
}
