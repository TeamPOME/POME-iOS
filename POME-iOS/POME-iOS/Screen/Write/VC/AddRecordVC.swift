//
//  AddRecordVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/19.
//

import UIKit

class AddRecordVC: BaseVC {
    
    // MARK: Properties
    
    /// 서버 통신 시 콤마가 없는 상태의 금액 저장을 위함
    private var price: Int = 0
    
    /// 버튼에 따라 다른 바텀시트를 띄우기 위함
    private var isGoalBtn: Bool = false
    
    // MARK: IBOutlet
    @IBOutlet weak var naviBar: PomeNaviBar!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var selectGoalBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calendarBtn: UIButton!
    @IBOutlet weak var priceTextField: PomeTextField!
    @IBOutlet weak var recordTextField: PomeTextField!
    @IBOutlet weak var confirmBtn: PomeBtn!

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTapBackBtn()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideTabbar()
    }
    
    // MARK: IBAction
    @IBAction func tapSelectGoalBtn(_ sender: UIButton) {
        showHalfModalVC(isGoalBtn: true)
    }
    
    @IBAction func tapCalendarBtn(_ sender: UIButton) {
        showHalfModalVC(isGoalBtn: false)
    }
    
    @IBAction func editRecordTextField(_ sender: UITextField) {
        sender.checkMaxLength(maxLength: 20)
    }
}

// MARK: - UI
extension AddRecordVC {
    
    private func configureUI() {
        naviBar.setNaviStyle(state: .whiteBackDefault)
        dateLabel.text = self.getSelectedDate(date: Date())
        calendarBtn.isEnabled = false
        priceTextField.setTextFieldStyle(state: .defaultStyle)
        priceTextField.configurePlaceholder(placeholder: "10,000")
        recordTextField.setTextFieldStyle(state: .defaultStyle)
        recordTextField.configurePlaceholder(placeholder: "소비에 대한 감상을 적어주세요 (20자)")
        confirmBtn.setTitle("작성했어요", for: .normal)
        confirmBtn.isDisabled = true
    }
}

// MARK: - Custom Methods
extension AddRecordVC {
    
    private func setDelegate() {
        priceTextField.delegate = self
        recordTextField.delegate = self
    }
    
    private func setTapBackBtn() {
        naviBar.backBtn.press { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - @objc
extension AddRecordVC {
    
    /// 만들어 둔 HalfModalVC 보여주는 함수
    @objc func showHalfModalVC(isGoalBtn: Bool) {
        self.isGoalBtn = isGoalBtn
        let halfModalVC = isGoalBtn ? SelectGoalVC() : CalendarVC()
        halfModalVC.modalPresentationStyle = .custom
        halfModalVC.transitioningDelegate = self
        self.present(halfModalVC, animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension AddRecordVC: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let halfModalVC = PomeHalfModalVC(presentedViewController: presented, presenting: presenting)
        
        /// HalfModalView의 높이 지정
        halfModalVC.modalHeight = isGoalBtn ? 348 : 448
        return halfModalVC
    }
}

// MARK: - UITextFieldDelegate
extension AddRecordVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        /// 모두 작성했으면 하단 작성했어요 버튼 활성화
        if !priceTextField.isEmpty && !recordTextField.isEmpty && goalLabel.textColor == .grey_9 && dateLabel.textColor == .grey_9 {
            confirmBtn.isDisabled = false
        } else {
            confirmBtn.isDisabled = true
        }
        
        /// 금액 세 자리마다 콤마 넣음
        if let currentNum = priceTextField.text, let price = Int(currentNum) {
            
            /// 서버 통신을 위한 콤마 없는 int값 저장
            self.price = price
            priceTextField.text = self.numberFormatter(number: price)
        }
    }
    
    /// 금액은 textField를 누르면 초기화 (콤마 넣기 위함)
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == priceTextField {
            priceTextField.text = ""
        }
    }
}
