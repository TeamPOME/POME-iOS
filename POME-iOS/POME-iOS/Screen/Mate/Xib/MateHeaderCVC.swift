//
//  MateHeaderCVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/10.
//

import UIKit

class MateHeaderCVC: BaseCVC {

    // MARK: IBOutlet
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isSelected: Bool {
        didSet {
            nameLabel.textColor = isSelected ? .grey_9 : .grey_5
            nameLabel.font = isSelected ? UIFont.PretendardSB(size: 12) : UIFont.PretendardM(size: 12)
        }
    }

}
