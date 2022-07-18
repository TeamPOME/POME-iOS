//
//  AddRecordVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/19.
//

import UIKit

class AddRecordVC: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var naviBar: PomeNaviBar!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var selectGoalBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceTextField: PomeTextField!
    @IBOutlet weak var recordTextField: PomeTextField!
    @IBOutlet weak var confirmBtn: PomeBtn!

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - UI
extension AddRecordVC {
    
    private func configureUI() {
        naviBar.setNaviStyle(state: .whiteBackDefault)
        priceTextField.setTextFieldStyle(state: .defaultStyle)
        priceTextField.configurePlaceholder(placeholder: "택시/건강 (5자)")
        recordTextField.setTextFieldStyle(state: .defaultStyle)
        recordTextField.configurePlaceholder(placeholder: "택시/건강 (5자)")
        confirmBtn.setTitle("작성했어요", for: .normal)
        confirmBtn.isDisabled = false
    }
}

// MARK: - Custom Methods
extension AddRecordVC {
    
}
