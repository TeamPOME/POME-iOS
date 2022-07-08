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
}

// MARK: - Network
extension FeelingCardCVC {
    func setData(_ num: Int) {
        remindNumLabel.text = "다시 돌아볼 씀씀이가 \(num)0건 있어요"
    }
}
