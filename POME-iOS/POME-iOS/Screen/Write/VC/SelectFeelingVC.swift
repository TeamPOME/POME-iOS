//
//  SelectFeelingVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/11.
//

import UIKit

class SelectFeelingVC: BaseVC {

    // MARK: IBOutlet
    @IBOutlet weak var naviBar: PomeNaviBar!
    @IBOutlet weak var saveEmojiBtn: PomeBtn!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBar()
        configureUI()
    }
    
    // MARK: IBAction
    
}

// MARK: - UI
extension SelectFeelingVC {
    
    private func configureNaviBar() {
        naviBar.setNaviStyle(state: .whiteBackDefault)
    }
    
    private func configureUI() {
        saveEmojiBtn.setTitle("남겼어요", for: .normal)
        saveEmojiBtn.isDisabled = true
    }
}
