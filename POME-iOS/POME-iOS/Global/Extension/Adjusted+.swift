//
//  Adjusted+.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/07.
//

import UIKit

/**
 - Description:
 스크린 너비 375를 기준으로 디자인이 나왔을 때 현재 기기의 스크린 사이즈에 비례하는 수치를 Return한다.
 
 - Note:
 기기별 대응에 사용하면 된다.
 ex) (size: 20.adjusted)
 */
extension CGFloat {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        return self * ratio
    }
    
    var adjustedH: CGFloat {
        if UIScreen.main.bounds.height < 812 {
            return self
        } else {
            let ratio: CGFloat = UIScreen.main.bounds.height / 812
            return self * ratio
        }
    }
}

extension Double {
    var adjusted: Double {
        let ratio: Double = Double(UIScreen.main.bounds.width / 375)
        return floor(self * ratio)
    }
    
    var adjustedH: Double {
        if UIScreen.main.bounds.height < 812 {
            return self
        } else {
            let ratio: Double = Double(UIScreen.main.bounds.height / 812)
            return floor(self * ratio)
        }
    }
}

