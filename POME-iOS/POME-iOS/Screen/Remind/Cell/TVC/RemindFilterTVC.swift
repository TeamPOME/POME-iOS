//
//  RemindFilterTVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/13.
//

import UIKit

class RemindFilterTVC: BaseTVC {

    // MARK: IBOutlet
    @IBOutlet weak var previousFeelingButton: UIButton!
    @IBOutlet weak var laterFeelingButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
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
extension RemindFilterTVC {
    
    private func configureUI() {
        [previousFeelingButton, resetButton, laterFeelingButton].forEach {
            $0?.backgroundColor = .grey_2
            $0?.makeRounded(cornerRadius: 4)
        }
        resetButton.backgroundColor = .grey_0
    }
}
