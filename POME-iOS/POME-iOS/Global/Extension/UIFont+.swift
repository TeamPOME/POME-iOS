//
//  UIFont+.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/06.
//

import UIKit

enum FontWeight {
    case regular, medium, semiBold, bold
}

extension UIFont {
    
    class func PretendardR(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Regular", size: size)!
    }
    
    class func PretendardM(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Medium", size: size)!
    }
    
    class func PretendardSB(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-SemiBold", size: size)!
    }
    
    class func PretendardB(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Bold", size: size)!
    }
}

