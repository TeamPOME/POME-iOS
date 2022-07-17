 //
//  AddGoalCompleteVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/17.
//

import UIKit

class AddGoalCompleteVC: BaseVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var confirmBtn: PomeBtn!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: IBAction
    @IBAction func tapConfirmBtn(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UI
extension AddGoalCompleteVC {
    
    private func configureUI() {
        titleLabel.setLineSpacing(lineSpacing: 4)
        confirmBtn.setTitle("확인했어요", for: .normal)
        confirmBtn.isDisabled = false
    }
}
