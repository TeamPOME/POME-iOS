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

// MARK: - Custom Method
extension CodeBaseTVC {
    
    /// 숫자를 천단위로 콤마를 넣어주는 메서드
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter.string(from: NSNumber(value: number))!
    }
}
