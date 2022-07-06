//
//  BaseTVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/07.
//

import UIKit

class BaseTVC: UITableViewCell {
    
}

// MARK: - TVRegisterable
extension BaseTVC: TVRegisterable {
    
    static var isFromNib: Bool {
        get {
            return true
        }
    }
}
