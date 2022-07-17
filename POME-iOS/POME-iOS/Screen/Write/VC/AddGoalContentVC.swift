//
//  AddGoalContentVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/17.
//

import UIKit

class AddGoalContentVC: BaseVC {

    // MARK: Properties
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    // MARK: IBOutlet
    @IBOutlet weak var naviBar: PomeNaviBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryTextField: PomeTextField!
    @IBOutlet weak var promiseTextField: PomeTextField!
    @IBOutlet weak var priceTextField: PomeTextField!
    @IBOutlet weak var confirmBtn: PomeBtn!
    @IBOutlet weak var openSwitch: UISwitch!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: IBAction
    @IBAction func tapCloseBtn(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Custom Methods
extension AddGoalContentVC {
    
    private func configureUI() {
        naviBar.setNaviStyle(state: .whiteBackDefault)
        titleLabel.setLineSpacing(lineSpacing: 4)
        categoryTextField.setTextFieldStyle(state: .defaultStyle)
        categoryTextField.configurePlaceholder(placeholder: "택시/건강 (5자)")
        promiseTextField.setTextFieldStyle(state: .defaultStyle)
        promiseTextField.configurePlaceholder(placeholder: "걸어다니기/건강 관리에는 넉넉히 쓰자 (12자)")
        priceTextField.setTextFieldStyle(state: .defaultStyle)
        priceTextField.configurePlaceholder(placeholder: "50,000")
        confirmBtn.setTitle("작성했어요", for: .normal)
        confirmBtn.isDisabled = true
    }
}
