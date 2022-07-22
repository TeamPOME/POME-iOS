//
//  AddRecordVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/19.
//

import UIKit

class AddRecordVC: BaseVC {
    
    // MARK: Properties
    
    /// 목표 리스트 바텀시트 띄울 때 해당 정보를 전달해서 띄움
    private var goalList: [GetGoalsResModel] = []
    
    /// 서버 통신 시 콤마가 없는 상태의 금액 저장을 위함
    private var price: Int = 0
    
    /// 서버 통신 시 선택한 목표의 id 값을 전달하기 위함
    private var goalId: Int = 0
    
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
    @IBOutlet weak var contentTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTapBackBtn()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getGoalGategory()
        hideTabbar()
        self.addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
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
        
        /// selectEmotion값은 아직 지정되지 않았기 때문에 0으로 셋팅해서 보낸다.
        writeSelectFeelingVC.newRecord = PostRecordResModel(id: goalId, date: dateLabel.text!, amount: price, content: recordTextField.text!, startEmotion: 0)
        
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
        bottomConstraint.constant = (screenHeight == 667) ? 34 : 0

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
    
    /// 노티피케이션을 추가하는 메서드
    private func addKeyboardNotifications(){
        
        /// 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        
        /// 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        /// 키보드 변경을 앱에게 알리는  메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(updateKeyboardFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    /// 노티피케이션을 제거하는 메서드
    private func removeKeyboardNotifications(){
        
        /// 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        
        /// 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        /// 키보드 변경을 앱에게 알리는  메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
}

// MARK: - @objc
extension AddRecordVC {
    
    /// 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ noti: NSNotification){
        if contentTopConstraint.constant == 12 {
            
            /// 화면을 올려준다.
            if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                
                /// 현재 키보드에 얼마나 가려지는지 계산
                let subHeight = keyboardHeight - (812.adjustedH - recordTextField.frame.maxY)

                /// 가려지는 부분이 있다면 키보드 처리를 한다.
                if subHeight > 0 {
                    contentTopConstraint.constant -= subHeight + 50
                    UIView.animate(withDuration: 0.1) {
                        self.view.layoutIfNeeded()
                    }
                }
            }
        }
    }
    
    /// 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        
        /// 초기 위치로 옮김
        contentTopConstraint.constant = 12
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    /// 키보드 변경 알림을 받으면 실행할 메서드
    @objc func updateKeyboardFrame(_ notification: Notification) {
        
        /// 바뀐 키보드의 frame.
        guard let keyboardEndFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        /// 바뀌기전 키보드의 frame.
        guard let keyboardBeginFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        
        /// 이미 올라와있는 상태일 때만 키보드 변경에 따라 처리함
        if contentTopConstraint.constant != 12 {
            
            /// 키보드 높이 차이 계산
            let subHeight = keyboardEndFrame.cgRectValue.height - keyboardBeginFrame.cgRectValue.height
            
            /// 바뀐 키보드가 더 높다면 (기본 -> 이모지) 그 차이 만큼 화면을 올려준다. 아니라면 화면을 내려준다.
            contentTopConstraint.constant -= subHeight
        }
    }
    
    /// 만들어 둔 HalfModalVC 보여주는 함수
    @objc func showHalfModalVC(isGoalBtn: Bool) {
        self.isGoalBtn = isGoalBtn
        
        /// 버튼 별 나와야 하는 뷰
        let selectGoalVC = SelectGoalVC()
        selectGoalVC.selectGoalDelegate = self
        selectGoalVC.goalList = self.goalList
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
        if screenHeight == 667 {
            halfModalVC.modalHeight = isGoalBtn ? 388 : 488
        } else {
            halfModalVC.modalHeight = isGoalBtn ? 348 : 448
        }
        return halfModalVC
    }
}

// MARK: - UITextFieldDelegate
extension AddRecordVC: UITextFieldDelegate {
    
    /// return을 누르면 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /// 입력이 끝났을 때
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
    
    func selectGoal(goalId: Int, goalLabel: String) {
        self.goalId = goalId
        self.goalLabel.text = goalLabel
        self.goalLabel.textColor = .grey_9
        calendarBtn.isEnabled = true
        checkFill()
    }
}

// MARK: - DeliveryDateDelegate
extension AddRecordVC: DeliveryDateDelegate {
    
    /// 받아온 데이터로 날짜 레이블 변경
    func deliveryDate(selectedDate: Date, isStartDate: Bool) {
        dateLabel.text = self.getSelectedDate(date: selectedDate)
    }
}

// MARK: - Network
extension AddRecordVC {
    
    /// 목표 카테고리 조회 요청 메서드
    private func getGoalGategory() {
        WriteAPI.shared.getGoalsAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? [GetGoalsResModel] {
                    DispatchQueue.main.async {
                        self.goalList = data
                    }
                }
            case .requestErr:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}
