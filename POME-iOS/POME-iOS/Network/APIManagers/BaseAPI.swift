//
//  BaseAPI.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/07.
//

import Foundation
import Alamofire

class BaseAPI {
    
    enum TimeOut {
        static let requestTimeOut: Float = 30
        static let resourceTimeOut: Float = 30
    }
    
    let AFmanager: Session = {
        var session = AF
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = TimeInterval(TimeOut.requestTimeOut)
        configuration.timeoutIntervalForResource = TimeInterval(TimeOut.resourceTimeOut)
        
        session = Session(configuration: configuration)
        return session
    }()
    
    func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ type: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<T>.self, from: data)
        else { return .pathErr }
        print(decodedData)
        switch statusCode {
        case 200...201:
            return .success(decodedData.data ?? "None-Data")
        case 202..<300:
            return .success(decodedData.status)
        case 400..<500:
            return .requestErr(decodedData.status)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
