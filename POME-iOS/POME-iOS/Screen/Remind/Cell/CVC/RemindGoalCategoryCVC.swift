//
//  RemindGoalCategoryCVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/14.
//

import UIKit

class RemindGoalCategoryCVC: BaseCVC {
    
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
