//
//  FeelingCardCVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/09.
//

import UIKit

class FeelingCardCVC: BaseCVC {
    
    // MARK: Properties
    var tapLookbackView: (() -> ())?
    
    // MARK: IBOutlet
    @IBOutlet weak var remindNumLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setTapCardEvent()
    }
}

// MARK: - Custom Methods
extension FeelingCardCVC {
    
    private func setTapCardEvent() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapCard))
        cardView.addGestureRecognizer(tapGesture)
    }
    
    func setData(num: Int) {
        remindNumLabel.text = "다시 돌아볼 씀씀이가 \(num)건 있어요"
    }
}

// MARK: - @objc
extension FeelingCardCVC {
    
    /// 카드를 탭 한 경우 화면 전환을 하기 위한 처리
    @objc func tapCard() {
        tapLookbackView?()
    }
}
