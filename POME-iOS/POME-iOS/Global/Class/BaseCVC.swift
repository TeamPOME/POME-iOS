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
