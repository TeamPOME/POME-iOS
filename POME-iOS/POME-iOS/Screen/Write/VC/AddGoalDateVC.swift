//
//  AddGoalDateVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/15.
//

import UIKit

class AddGoalDateVC: BaseVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var naviBar: PomeNaviBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var confirmBtn: PomeBtn!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: IBAction
    @IBAction func tapStartCalendar(_ sender: UIButton) {
        print("첫번째")
    }

    @IBAction func tapEndCalendar(_ sender: UIButton) {
        print("두번째")
    }
    
    @IBAction func tapConfirmBtn(_ sender: UIButton) {
    }
}

// MARK: - Custom Methods
extension AddGoalDateVC {
    
    private func configureUI() {
        naviBar.setNaviStyle(state: .whiteBackDefault)
        titleLabel.setLineSpacing(lineSpacing: 4)
        titleLabel.textAlignment = .left
        confirmBtn.setTitle("선택했어요", for: .normal)
    }
}
