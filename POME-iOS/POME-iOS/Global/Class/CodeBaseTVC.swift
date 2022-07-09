//
//  CodeBaseTVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/07.
//

import UIKit

class CodeBaseTVC: UITableViewCell {

    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        
    }
}

// MARK: - TVRegisterable
extension CodeBaseTVC: TVRegisterable {
    
    static var isFromNib: Bool {
        get {
            return false
        }
    }
}
