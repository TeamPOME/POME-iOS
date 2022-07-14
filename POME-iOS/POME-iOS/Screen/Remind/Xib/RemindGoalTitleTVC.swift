//
//  RemindGoalTitleTVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/13.
//

import UIKit

class RemindGoalTitleTVC: BaseTVC{

    // MARK: IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var isPrivateImageView: UIImageView!
    @IBOutlet weak var goalTitleLabel: UILabel!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
    }
    
}

// MARK: - UI
extension RemindGoalTitleTVC {
    
    private func configureUI() {
        containerView.makeRounded(cornerRadius: 6)
        containerView.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.1, radius: 6)
    }
}
