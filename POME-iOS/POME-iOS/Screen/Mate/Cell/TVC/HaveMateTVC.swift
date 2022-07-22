//
//  haveMateTVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/10.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class HaveMateTVC: BaseTVC {
    
    // MARK: Properties
    var tapPlusBtnAction: (() -> ())?
    var tapMateEmojiBtnAction: (() -> ())?
    
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
    
    @IBAction func tapPlusBtn(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(named: "btnEmojiNor28") {
            tapPlusBtnAction?()
        } else {
            tapMateEmojiBtnAction?()
        }
    }
    @IBAction func tapMateFirstEmojiBtn(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(named: "btnEmojiNor28") {
            tapPlusBtnAction?()
        } else {
            tapMateEmojiBtnAction?()
        }
    }
    @IBAction func tapMateThirdEmojiBtn(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(named: "btnEmojiNor28") {
            tapPlusBtnAction?()
        } else {
            tapMateEmojiBtnAction?()
        }
    }
}

// MARK: - UI
extension HaveMateTVC {
    
    private func configureUI() {
        contentLabelHeight.constant = 37
        profileImageView.maskImage = UIImage(named: "userProfileFill32")
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

// MARK: - Custom Methods
extension HaveMateTVC {
    
    func setData(data: GetMateRecordResModel) {
        let url = URL(string: data.profileImage)
        profileImageView.kf.setImage(with: url)
        nameLabel.text = data.nickname
        spentMoneyLabel.text = "\(self.numberFormatter(number: data.amount))원"
        contentLabel.text = data.content
        goalLabel.text = data.goalMessage
        smileEmojiBtn.setImage(NumToEmoji.mateFirst(num: data.startEmotion), for: .normal)
        sadEmojiBtn.setImage(NumToEmoji.mateSecond(num: data.endEmotion), for: .normal)
        
        /// 아무도 감정 안남김
        if data.reactions[2] == 0 && data.reactions[1] == 0 && data.reactions[0] == 0 {
            countMateLabel.isHidden = true
            [firstEmojiContainerBtn, secondEmojiContainerBtn].forEach {
                btn in btn?.isHidden = true
            }
            thirdEmojiContainerBtn.setImage(UIImage(named: "btnEmojiNor28"), for: .normal)
        }
        
        /// 나만 감정 달았을 때
        if data.reactions[2] == 0 && data.reactions[1] == 0 && data.reactions[0] != 0 {
            countMateLabel.isHidden = true
            [firstEmojiContainerBtn, secondEmojiContainerBtn].forEach {
                btn in btn.isHidden = true
            }
            
            switch data.reactions[0] {
            case 1:
                thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiHappyMint28"), for: .normal)
            case 2:
                thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSmileMint28"), for: .normal)
            case 3:
                thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFunnyMint28"), for: .normal)
            case 4:
                thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFlexMint28"), for: .normal)
            case 5:
                thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiWhayMint28"), for: .normal)
            default:
                thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSadMint28"), for: .normal)
            }
        }
        
        /// 친구 한명이 감정 남겼을 때 (버튼이 두개)
        if data.reactions[2] == 0 && data.reactions[1] != 0  {
            countMateLabel.isHidden = true
            firstEmojiContainerBtn.isHidden = true
            if data.reactions[0] == 0 {
                /// 두번째 버튼에 +이미지
                secondEmojiContainerBtn.setImage(UIImage(named: "btnEmojiNor28"), for: .normal)
                /// 세번째버튼에 친구 한명이 남긴 감정 표시
                switch data.reactions[1] {
                case 1:
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiHappyMint28"), for: .normal)
                case 2:
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSmileMint28"), for: .normal)
                case 3:
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFunnyMint28"), for: .normal)
                case 4:
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFlexMint28"), for: .normal)
                case 5:
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiWhayMint28"), for: .normal)
                default:
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSadMint28"), for: .normal)
                }
            /// 내가 감정을 남긴경우
            } else {
                switch data.reactions[0] {
                case 1:
                    secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiHappyMint28"), for: .normal)
                case 2:
                    secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSmileMint28"), for: .normal)
                case 3:
                    secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFunnyMint28"), for: .normal)
                case 4:
                    secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFlexMint28"), for: .normal)
                case 5:
                    secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiWhayMint28"), for: .normal)
                default:
                    secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSadMint28"), for: .normal)
                }
            }
        }
        
        /// 보이는 버튼이 세개인 경우
        /// 나는 감정 안남김
        if data.reactions[0] == 0 && data.reactions[1] != 0 && data.reactions[2] != 0 {
            if data.plusCount > 0 {
                countMateLabel.isHidden = false
                countMateLabel.text = "+\(data.plusCount)"
            } else {
                countMateLabel.isHidden = true
            }
            
            /// 첫번째 버튼에 +이미지
            firstEmojiContainerBtn.setImage(UIImage(named: "btnEmojiNor28"), for: .normal)
            switch data.reactions[1] {
            case 1:
                secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiHappyMint28"), for: .normal)
            case 2:
                secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSmileMint28"), for: .normal)
            case 3:
                secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFunnyMint28"), for: .normal)
            case 4:
                secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFlexMint28"), for: .normal)
            case 5:
                secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiWhayMint28"), for: .normal)
            default:
                secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSadMint28"), for: .normal)
            }
            
            switch data.reactions[2] {
            case 1:
                thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiHappyMint28"), for: .normal)
            case 2:
                thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSmileMint28"), for: .normal)
            case 3:
                thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFunnyMint28"), for: .normal)
            case 4:
                thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFlexMint28"), for: .normal)
            case 5:
                thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiWhayMint28"), for: .normal)
            default:
                thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSadMint28"), for: .normal)
            }
        }
        
        /// 보이는 버튼 세개
        /// 내가 감정달고 친구 두명이상 감정 달았을때
        if data.reactions[0] != 0 && data.reactions[1] != 0 && data.reactions[2] != 0 {
            if data.plusCount > 0 {
                countMateLabel.isHidden = false
                countMateLabel.text = "+\(data.plusCount)"
            } else {
                countMateLabel.isHidden = true
            }
            
            [firstEmojiContainerBtn, secondEmojiContainerBtn].forEach {
                btn in btn?.isHidden = false
            }
            
            switch data.reactions[0] {
            case 1:
                firstEmojiContainerBtn.setImage(UIImage(named: "property1EmojiHappyMint28"), for: .normal)
            case 2:
                firstEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSmileMint28"), for: .normal)
            case 3:
                firstEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFunnyMint28"), for: .normal)
            case 4:
                firstEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFlexMint28"), for: .normal)
            case 5:
                firstEmojiContainerBtn.setImage(UIImage(named: "property1EmojiWhayMint28"), for: .normal)
            default:
                firstEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSadMint28"), for: .normal)
            }
            
            switch data.reactions[1] {
            case 1:
                secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiHappyMint28"), for: .normal)
            case 2:
                secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSmileMint28"), for: .normal)
            case 3:
                secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFunnyMint28"), for: .normal)
            case 4:
                secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFlexMint28"), for: .normal)
            case 5:
                secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiWhayMint28"), for: .normal)
            default:
                secondEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSadMint28"), for: .normal)
            }
            
            switch data.reactions[2] {
            case 1:
                if data.plusCount > 0 {
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiHappyMint28Overlay"), for: .normal)
                } else {
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiHappyMint28"), for: .normal)
                }
    
            case 2:
                if data.plusCount > 0 {
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSmileMint28Overlay"), for: .normal)
                } else {
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSmileMint28"), for: .normal)
                }
            case 3:
                if data.plusCount > 0 {
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFunnyMint28Overlay"), for: .normal)
                } else {
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFunnyMint28"), for: .normal)
                }
            case 4:
                if data.plusCount > 0 {
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFlexMint28Overlay"), for: .normal)
                } else {
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiFlexMint28"), for: .normal)
                }
            case 5:
                if data.plusCount > 0 {
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiWhayMint28Overlay"), for: .normal)
                } else {
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiWhayMint28"), for: .normal)
                }
            default:
                if data.plusCount > 0 {
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSadMint28Overlay"), for: .normal)
                } else {
                    thirdEmojiContainerBtn.setImage(UIImage(named: "property1EmojiSadMint28"), for: .normal)
                }
            }
        }
    }
}
