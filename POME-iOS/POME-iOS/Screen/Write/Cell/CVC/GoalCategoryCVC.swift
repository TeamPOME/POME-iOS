//
//  GoalCategoryCVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/09.
//

import UIKit

class GoalCategoryCVC: BaseCVC {

    // MARK: IBOutlet
    @IBOutlet weak var goalLabel: UILabel!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isSelected: Bool {
        didSet{
            goalLabel.textColor = isSelected ? .white : .grey_5
            backgroundColor = isSelected ? .main : .clear
        }
    }
}
