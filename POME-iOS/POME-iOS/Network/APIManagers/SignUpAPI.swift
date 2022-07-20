//
//  SignUpAPI.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/20.
//

import Foundation

class SignUpAPI {
    static let shared = SignUpAPI()
    
    // POST - Image 송신
    // data : UIImage 를 pngData() 혹은 jpegData() 사용해서 Data 로 변환한 것.
    // filename : 파일이름(img.jpg 과 같은 이름)
    // mimeType :  타입에 맞게 png면 image/png, text text/plain 등 타입.
    
    /// [POST] 회원가입 요청
    func requestPOSTWithMultipartform(url: String,
                                      parameters: [String : String],
                                      data: Data,
                                      filename: String,
                                      mimeType: String,
                                      completionHandler: @escaping (NetworkResult<Any>) -> (Void)) {
        
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        
        /// boundary 설정
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        /// data
        var uploadData = Data()
        let imgDataKey = "file"
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            uploadData.append(boundaryPrefix.data(using: .utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            uploadData.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        uploadData.append(boundaryPrefix.data(using: .utf8)!)
        uploadData.append("Content-Disposition: form-data; name=\"\(imgDataKey)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        uploadData.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        uploadData.append(data)
        uploadData.append("\r\n".data(using: .utf8)!)
        uploadData.append("--\(boundary)--".data(using: .utf8)!)
        
        
        let defaultSession = URLSession(configuration: .default)
        defaultSession.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                print("Error occur: error calling POST - \(String(describing: error))")
                return
            }
            
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("Error: HTTP request failed")
                return
            }
            
            let networkResult = self.judgeStatus(by: response.statusCode, data, type: SignUpResModel.self)
            
            completionHandler(networkResult)
        }.resume()
    }
    
    func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, type: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<T>.self, from: data)
        else { return .pathErr }
        
        switch statusCode {
        case 200...202:
            return .success(decodedData.data ?? "None-Data")
        case 203..<300:
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
