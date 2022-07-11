//
//  haveMateTVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/10.
//

import UIKit
import SnapKit
import Then

class HaveMateTVC: BaseTVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImageView: PomeMaskedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var spentMoneyLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sadEmojiContainerView: UIView!
    @IBOutlet weak var sadEmojiBtn: UIButton!
    @IBOutlet weak var smileEmojiContainerView: UIView!
    @IBOutlet weak var smileEmojiBtn: UIButton!
    @IBOutlet weak var goalLabelContainerView: UIView!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var firstEmojiContainerBtn: UIButton!
    @IBOutlet weak var secondEmojiContainerBtn: UIButton!
    @IBOutlet weak var thirdEmojiContainerBtn: UIButton!
    @IBOutlet weak var countMateLabel: UILabel!
    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}

// MARK: - UI
extension HaveMateTVC {
    
    private func configureUI() {
        
        configureLabelLine()
        configureRoundedCorner()
        configureMask()
        configureHeight()
    }
    
    /// 이미지에 마스크 씌우기
    private func configureMask() {
        profileImageView.maskImage = UIImage(named: "userProfileFill32")
    }
    
    /// content내용의 셀이 비율에 맞게 설정되게 함
    private func configureHeight() {
        contentLabelHeight.constant = 37.adjustedH
    }
    
    private func configureRoundedCorner() {
        sadEmojiContainerView.makeRounded(cornerRadius: sadEmojiContainerView.frame.width / 2)
        smileEmojiContainerView.makeRounded(cornerRadius: smileEmojiContainerView.frame.width / 2)
        goalLabelContainerView.makeRounded(cornerRadius: 4.adjusted)
    }
    
    /// 글자가 layout에서 벗어나면 두줄로 보일 수 있도록 함
    private func configureLabelLine() {
        contentLabel.sizeToFit()
        contentLabel.numberOfLines = 2
    }
}
