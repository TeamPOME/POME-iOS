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
    
    @IBAction func tapConfirmBtn(_ sender: UIButton) {
        guard let writeSelectFeelingVC = UIStoryboard.init(name: Identifiers.WriteSelectFeelingSB, bundle: nil).instantiateViewController(withIdentifier: WriteSelectFeelingVC.className) as? WriteSelectFeelingVC else { return }
        writeSelectFeelingVC.isRecord = true
        navigationController?.pushViewController(writeSelectFeelingVC, animated: true)
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
    
    private func checkFill() {
        
        /// 모두 작성했으면 하단 작성했어요 버튼 활성화
        if !priceTextField.isEmpty && !recordTextField.isEmpty && goalLabel.textColor == .grey_9 {
            confirmBtn.isDisabled = false
        } else {
            confirmBtn.isDisabled = true
        }
    }
}

// MARK: - @objc
extension AddRecordVC {
    
    /// 만들어 둔 HalfModalVC 보여주는 함수
    @objc func showHalfModalVC(isGoalBtn: Bool) {
        self.isGoalBtn = isGoalBtn
        
        /// 버튼 별 나와야 하는 뷰 
        let selectGoalVC = SelectGoalVC()
        selectGoalVC.selectGoalDelegate = self
        let calendarVC = CalendarVC()
        calendarVC.deliveryDateDelegate = self
        calendarVC.startDate = self.getStringToDate(string: dateLabel.text!)
        
        let halfModalVC = isGoalBtn ? selectGoalVC : calendarVC
        halfModalVC.modalPresentationStyle = .custom
        halfModalVC.transitioningDelegate = self
        self.present(halfModalVC, animated: true, completion: nil)
        }
}

// MARK: - UIViewControllerTransitioningDelegate
extension AddRecordVC: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let halfModalVC = PomeHalfModalVC(presentedViewController: presented, presenting: presenting)
        
        /// 바텀 시트로 띄울 뷰의 종류에 따라 HalfModalView의 높이 지정
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
        checkFill()
        
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

// MARK: - SelectGoalDelegate
extension AddRecordVC: SelectGoalDelegate {
    
    func selectGoal(goalLabel: String) {
        self.goalLabel.text = goalLabel
        self.goalLabel.textColor = .grey_9
        calendarBtn.isEnabled = true
        checkFill()
    }
}

// MARK: - DeliveryDateDelegate
extension AddRecordVC: DeliveryDateDelegate{
    
    /// 받아온 데이터로 날짜 레이블 변경
    func deliveryDate(selectedDate: Date, isStartDate: Bool) {
        dateLabel.text = self.getSelectedDate(date: selectedDate)
    }
}
