//
//  Bundle+.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/19.
//

import Foundation

extension Bundle {
    
        /// 생성한 .plist 파일 경로 불러오기
        var KAKAO_APP_KEY: String {
            guard let file = self.path(forResource: "PomeInfo", ofType: "plist") else { return "" }
            
            // .plist를 딕셔너리로 받아오기
            guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
            
            // 딕셔너리에서 값 찾기
            guard let key = resource["KAKAO_APP_KEY"] as? String else {
                fatalError("KAKAO_APP_KEY error")
            }
            return key
        }
}
