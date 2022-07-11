//
//  MateHeaderCVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/10.
//

import UIKit

class MateHeaderCVC: BaseCVC {

    // MARK: IBOutlet
    @IBOutlet weak var profileImageView: PomeMaskedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}

// MARK: - UI
extension MateHeaderCVC {
    
    func configureUI() {
        profileImageView.maskImage = UIImage(named: "userProfileFill32")
    }
}
