//
//  RemindFilterTVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/13.
//

import UIKit

class RemindFilterTVC: BaseTVC {

    // MARK: Properties
    var closure: ((Int) -> ())?
    var tapFirstEmotionAction: ((Int) -> ())?
    var tapLaterEmotionAction: ((Int) -> ())?
    
    // MARK: IBOutlet
    @IBOutlet weak var previousFeelingBtn: UIButton!
    @IBOutlet weak var laterFeelingBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
    }
    @IBAction func tapFirstEmotionAction(_ sender: Any) {
        self.closure?(0)
    }
    @IBAction func tapLaterEmotionAction(_ sender: Any) {
        closure?(1)
    }
    @IBAction func tapResetButton(_ sender: Any) {
        
    }
}

// MARK: - UI
extension RemindFilterTVC {
    
    private func configureUI() {
        [previousFeelingBtn, resetBtn, laterFeelingBtn].forEach {
            $0?.backgroundColor = .grey_2
            $0?.makeRounded(cornerRadius: 4.adjusted)
        }
        resetBtn.backgroundColor = .grey_0
    }
}
