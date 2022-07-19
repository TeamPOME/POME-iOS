//
//  CodeBaseCVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/07.
//

import UIKit

class CodeBaseCVC: UICollectionViewCell {
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setViews() {
        
    }
}

// MARK: - CVRegisterable
extension CodeBaseCVC: CVRegisterable {
    
    static var isFromNib: Bool {
        get {
            return false
        }
    }
}

// MARK: - Custom Method
extension CodeBaseCVC {
    
    /// 숫자를 백단위로 콤마를 넣어주는 메서드
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter.string(from: NSNumber(value: number))!
    }
}
