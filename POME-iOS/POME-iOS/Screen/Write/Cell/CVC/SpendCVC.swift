//
//  SpendCVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/08.
//

import UIKit

class SpendCVC: BaseCVC {
    
    // MARK: Properties
    
    /// 액션 시트를 띄우기 위한 클로저 선언
    var tapMoreBtn: (() -> ())?
    var tapPlusBtn: (() -> ())?

    // MARK: IBOutlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var leftEmojiImageView: UIImageView!
    @IBOutlet weak var rightEmojiBtn: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: IBAction
    @IBAction func tapMoreBtn(_ sender: UIButton) {
        tapMoreBtn?()
    }
    
    @IBAction func tapPlusBtn(_ sender: UIButton) {
        tapPlusBtn?()
    }
}

// MARK: - Custom Methods
extension SpendCVC {
    func setData() {
        
        // TODO: - 네트워크 통신할 때 코드 추가 필요
    }
}
