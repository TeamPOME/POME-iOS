//
//  RemindFilterTVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/13.
//

import UIKit

class RemindFilterTVC: BaseTVC {

    // MARK: Properties
    var selectFilterAction: ((Int) -> ())?
    var selectResetBtnClosure: ((Bool) -> ())?
    
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
    
    // MARK: IBAction
    @IBAction func tapPreviousEmotionBtn(_ sender: Any) {
        selectFilterAction?(0)
    }
    
    @IBAction func tapLaterEmotionBtn(_ sender: Any) {
        selectFilterAction?(1)
    }
    
    @IBAction func tapResetBtn(_ sender: Any) {
        [previousFeelingBtn, laterFeelingBtn].forEach {
            $0?.backgroundColor = .grey_2
            $0?.setTitleColor(.grey_5, for: .normal)
            $0?.tintColor = .grey_5
            $0?.makeRounded(cornerRadius: 4.adjusted)
            $0?.setImage(UIImage(named: "icArrowDown17"), for: .normal)
            $0?.semanticContentAttribute = .forceRightToLeft
        }
        previousFeelingBtn.setTitle("처음 감정", for: .normal)
        laterFeelingBtn.setTitle("돌아본 감정", for: .normal)
        selectResetBtnClosure?(true)
    }
}

// MARK: - UI
extension RemindFilterTVC {
    
    private func configureUI() {
        [previousFeelingBtn, resetBtn, laterFeelingBtn].forEach {
            $0?.backgroundColor = .grey_2
            $0?.setTitleColor(.grey_5, for: .normal)
            $0?.tintColor = .grey_5
            $0?.makeRounded(cornerRadius: 4.adjusted)
        }
        
        [previousFeelingBtn, laterFeelingBtn].forEach {
            $0?.setImage(UIImage(named: "icArrowDown17"), for: .normal)
            $0?.semanticContentAttribute = .forceRightToLeft
        }
        resetBtn.backgroundColor = .grey_0
    }
}
