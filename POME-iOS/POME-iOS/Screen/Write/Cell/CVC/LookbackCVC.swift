//
//  LookbackCVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/11.
//

import UIKit

class LookbackCVC: BaseCVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var goalBgView: UIView!
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var spendCountLabel: UILabel!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Custom Methods
extension LookbackCVC {
    
    func setData(goal: String, num: Int) {
        goalLabel.text = goal
        spendCountLabel.text = "전체 \(num)건"
    }
}
