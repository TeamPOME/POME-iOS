 //
//  AddGoalCompleteVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/17.
//

import UIKit

class AddCompleteVC: BaseVC {
    
    // MARK: Properties
    var isRecord: Bool = false
    
    // MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var confirmBtn: PomeBtn!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setNaviBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setNaviBar()
    }
    
    // MARK: IBAction
    @IBAction func tapConfirmBtn(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UI
extension AddCompleteVC {
    
    private func configureUI() {
        if isRecord {
            titleLabel.text = "새로운 씀씀이 기록이\n추가되었어요!"
            subLabel.text = "잊지 않고 기록해주셨네요! 정말 대단해요"
            mainImageView.image = UIImage(named: "writeComplete3DComponent")
        }
        titleLabel.setLineSpacing(lineSpacing: 4)
        confirmBtn.setTitle("확인했어요", for: .normal)
        confirmBtn.isDisabled = false
    }
}

// MARK: - Custom Methods
extension AddCompleteVC {
    
    /// 오른쪽으로 swipe시 뒤로가기 활성화 여부
    private func setNaviBar() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled.toggle()
    }
}
