//
//  NetworkResult.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/07.
//

import Foundation

/*
 NetworkResult : 네트워크 결과를 나눔
 */

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
