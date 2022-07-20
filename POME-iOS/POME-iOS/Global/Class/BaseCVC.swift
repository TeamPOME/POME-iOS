//
//  BaseCVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/07.
//

import UIKit

class BaseCVC: UICollectionViewCell {
    
}

// MARK: - CVRegisterable
extension BaseCVC: CVRegisterable {
    
    static var isFromNib: Bool {
        get {
            return true
        }
    }
}

// MARK: - Custom Method
extension BaseCVC {
    
    /// 숫자를 천단위로 콤마를 넣어주는 메서드
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter.string(from: NSNumber(value: number))!
    }
}
