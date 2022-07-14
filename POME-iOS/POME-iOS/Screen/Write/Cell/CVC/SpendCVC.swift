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

    // MARK: IBOutlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var leftEmojiImageView: UIImageView!
    @IBOutlet weak var rightEmojiImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: IBAction
    @IBAction func tapMoreBtn(_ sender: Any) {
        tapMoreBtn?()
    }
}
