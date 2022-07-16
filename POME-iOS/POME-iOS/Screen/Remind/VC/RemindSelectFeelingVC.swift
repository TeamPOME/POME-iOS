//
//  SelectFeelingVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/15.
//

import UIKit

protocol SelectFeelingDelegate {
    func selectPreviousEmoji(previousEmoji: String)
    func selectLatestEmoji(latestEmoji: String)
}

class RemindSelectFeelingVC: BaseVC {

    // MARK: Properties
    var selectFeelingDelegate: SelectFeelingDelegate?
    var isFirstEmotion: Bool = true
    var isButtonSelected: Bool = false
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            if isFirstEmotion {
                titleLabel?.setLabel(text: "처음 감정", color: .pomeBlack, size: 14, weight: .semiBold)
            } else {
                titleLabel?.setLabel(text: "돌아본 감정", color: .pomeBlack, size: 14, weight: .semiBold)
            }
        }
    }
    @IBOutlet weak var happyBtn: UIButton! {
        didSet {
            if isFirstEmotion {
                happyBtn?.setImage(UIImage(named: "emojiMintHappyFiter54"), for: .normal)
            } else {
                happyBtn?.setImage(UIImage(named: "emojiPinkHappyFiter54"), for: .normal)
            }
        }
    }
    @IBOutlet weak var dontKnowBtn: UIButton! {
        didSet {
            if isFirstEmotion {
                dontKnowBtn?.setImage(UIImage(named: "emojiMintNotSureFiter54"), for: .normal)
            } else {
                dontKnowBtn?.setImage(UIImage(named: "emojiPinkNotSureFiter54"), for: .normal)
            }
        }
    }
    @IBOutlet weak var regretBtn: UIButton! {
        didSet {
            if isFirstEmotion {
                regretBtn?.setImage(UIImage(named: "emojiMintRegretFiter54"), for: .normal)
            } else {
                regretBtn?.setImage(UIImage(named: "emojiPinkRegretFiter54"), for: .normal)
            }
        }
    }
    
    // MARK: IBAction
    @IBAction func happyBtnTap(_ sender: Any) {
        if isFirstEmotion {
            selectFeelingDelegate?.selectPreviousEmoji(previousEmoji: "행복해요")
        } else {
            selectFeelingDelegate?.selectLatestEmoji(latestEmoji: "행복해요")
        }
        isButtonSelected = true
        self.dismiss(animated: true)
    }
    @IBAction func dontKnowBtnTap(_ sender: Any) {
        if isFirstEmotion {
            selectFeelingDelegate?.selectPreviousEmoji(previousEmoji: "모르겠어요")
        } else {
            selectFeelingDelegate?.selectLatestEmoji(latestEmoji: "모르겠어요")
        }
        isButtonSelected = true
        self.dismiss(animated: true)
    }
    @IBAction func regretBtnTap(_ sender: Any) {
        if isFirstEmotion {
            selectFeelingDelegate?.selectPreviousEmoji(previousEmoji: "후회해요")
        } else {
            selectFeelingDelegate?.selectLatestEmoji(latestEmoji: "후회해요")
        }
        isButtonSelected = true
        self.dismiss(animated: true)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isButtonSelected = false
    }
}
