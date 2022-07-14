//
//  RemindGoalTVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/13.
//

import UIKit

class RemindGoalTVC: BaseTVC {
    
    // MARK: Properties
    let isPrivate = false
    
    // MARK: IBOutlet
    @IBOutlet weak var containerView: UIView!
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
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}

// MARK: - UI
extension RemindGoalTVC {
    
    private func configureUI() {
        sadEmojiContainerView.makeRounded(cornerRadius: sadEmojiContainerView.frame.width / 2)
        smileEmojiContainerView.makeRounded(cornerRadius: smileEmojiContainerView.frame.width / 2)
        goalLabelContainerView.makeRounded(cornerRadius: 4.adjusted)

        /// 글자가 layout에서 벗어나면 두줄로 보일 수 있도록 함
        contentLabel.sizeToFit()
        contentLabel.numberOfLines = 2
        
        /// 전체 셀 안의 containerView에 그림자와 radius 값 지정
        containerView.makeRounded(cornerRadius: 8)
        containerView.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.1, radius: 4)
    }
}

// MARK: - Network
extension RemindGoalTVC {
    
    func setData(_ remindGoalData: RemindGoalDataModel) {
        goalLabel.text = remindGoalData.goalTitle
        spentMoneyLabel.text = remindGoalData.spentMoneyLabel
        contentLabel.text = remindGoalData.content
        if remindGoalData.countMate == 0 {
            [firstEmojiContainerBtn, secondEmojiContainerBtn, thirdEmojiContainerBtn].forEach {
                $0.isHidden = true
            }
        } else {
            [firstEmojiContainerBtn, secondEmojiContainerBtn, thirdEmojiContainerBtn].forEach {
                $0.isHidden = false
            }
            countMateLabel.text = "\(remindGoalData.countMate)+"
        }
    }
}
