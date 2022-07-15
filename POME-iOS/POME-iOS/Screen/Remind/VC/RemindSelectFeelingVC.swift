//
//  SelectFeelingVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/15.
//

import UIKit

protocol TVCellDelegate {
    func selectendEmojiBtn(_ index : Int)
}

class RemindSelectFeelingVC: BaseVC {

    // MARK: Properties
    var delegate: TVCellDelegate?
    var isFirstEmotion: Bool = true
    var closure: ((Int) -> ())?
    
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
        closure?(0)
    }
    @IBAction func dontKnowBtnTap(_ sender: Any) {
        closure?(1)
    }
    @IBAction func regretBtnTap(_ sender: Any) {
        closure?(2)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
