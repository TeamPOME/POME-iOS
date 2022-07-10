//
//  FeelingCardCVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/09.
//

import UIKit

class FeelingCardCVC: BaseCVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var remindNumLabel: UILabel!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Custom Methods
extension FeelingCardCVC {
    
    func setData(num: Int) {
        remindNumLabel.text = "다시 돌아볼 씀씀이가 \(num)건 있어요"
    }
}
