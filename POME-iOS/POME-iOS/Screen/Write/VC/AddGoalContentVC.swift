//
//  AddGoalContentVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/17.
//

import UIKit

class AddGoalContentVC: BaseVC {
    
    // MARK: Properties
    var startDate: String = ""
    var endDate: String = ""
    
    /// 서버 통신 시 콤마가 없는 상태의 금액 저장을 위함
    var price: Int = 0
    
    // MARK: IBOutlet
    @IBOutlet weak var naviBar: PomeNaviBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryTextField: PomeTextField!
    @IBOutlet weak var promiseTextField: PomeTextField!
    @IBOutlet weak var priceTextField: PomeTextField!
    @IBOutlet weak var confirmBtn: PomeBtn!
    @IBOutlet weak var openSwitch: UISwitch!
    @IBOutlet weak var switchBackView: UIView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDelegate()
        setTapBackBtn()
    }
    
    // MARK: IBAction
    @IBAction func tapCloseBtn(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func editCategoryTextField(_ sender: UITextField) {
        checkMaxLength(textField: categoryTextField, maxLength: 5)
    }
    
    @IBAction func editPromiseTextField(_ sender: UITextField) {
        checkMaxLength(textField: promiseTextField, maxLength: 12)
    }
    
    @IBAction func tapOpenSwitch(_ sender: UISwitch) {
        switchBackView.backgroundColor = sender.isOn ? .pomeLightPink : .grey_0
    }
    
    @IBAction func tapConfirmBtn(_ sender: UIButton) {
        
        // TODO: - 서버 통신 필요
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UI
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

// MARK: - Custom Methods
extension AddGoalContentVC {
    
    private func setDelegate() {
        categoryTextField.delegate = self
        promiseTextField.delegate = self
        priceTextField.delegate = self
    }
    
    private func setTapBackBtn() {
        naviBar.backBtn.press { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    /// 글자수 제한 함수
    private func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    /// 세 자리마다 콤마를 넣음
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
}

// MARK: - Types
extension AddGoalContentVC: UITextFieldDelegate {
    
    /// 리턴을 누르면 다음 텍스트 필드로 이동, 다음 텍스트 필드가 차있으면 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == categoryTextField {
            if promiseTextField.isEmpty {
                promiseTextField.becomeFirstResponder()
            } else if priceTextField.isEmpty {
                priceTextField.becomeFirstResponder()
            }
        } else if textField == promiseTextField && priceTextField.isEmpty {
            priceTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        /// 세 텍스트 필드 모두 작성했으면 하단 작성했어요 버튼 활성화
        if !categoryTextField.isEmpty && !promiseTextField.isEmpty && !priceTextField.isEmpty {
            confirmBtn.isDisabled = false
        } else {
            confirmBtn.isDisabled = true
        }
        
        /// 금액 세 자리마다 콤마 넣음
        if let currentNum = priceTextField.text, let price = Int(currentNum) {
            
            /// 서버 통신을 위한 콤마 없는 int값 저장
            self.price = price
            priceTextField.text = numberFormatter(number: price)
        }
    }
    
    /// 목표 금액은 textField를 누르면 초기화 (콤마 넣기 위함)
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == priceTextField {
            priceTextField.text = ""
        }
    }
}
