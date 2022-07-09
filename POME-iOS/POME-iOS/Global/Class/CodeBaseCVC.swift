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
