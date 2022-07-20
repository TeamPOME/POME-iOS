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
    private var price: Int = 0
    
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
        let alert = PomeAlertVC()
        alert.showPomeAlertVC(vc: self, title: "작성을 그만 두시겠어요?", subTitle: "지금까지 작성한 내용은 모두 사라져요", cancelBtnTitle: "이어서 쓸래요", confirmBtnTitle: "그만둘래요", iconImage: UIImage(named: "3DPenMint100"))
        
        /// 알럿창의 이어서 쓸래요(왼쪽 버튼) 누르는 경우 alert dismiss
        alert.cancelBtn.press { [weak self] in
            self?.dismiss(animated: true)
        }
        
        /// 알럿창의 그만둘래요(오른쪽 버튼) 누르는 경우 알럿창 없앤 후 기록탭 메인으로 돌아감
        alert.confirmBtn.press { [weak self] in
            self?.dismiss(animated: false) {
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @IBAction func editCategoryTextField(_ sender: UITextField) {
        sender.checkMaxLength(maxLength: 5)
    }
    
    @IBAction func editPromiseTextField(_ sender: UITextField) {
        sender.checkMaxLength(maxLength: 12)
    }
    
    @IBAction func tapOpenSwitch(_ sender: UISwitch) {
        switchBackView.backgroundColor = sender.isOn ? .pomeLightPink : .grey_0
    }
    
    @IBAction func tapConfirmBtn(_ sender: UIButton) {
        postGoal(startDate: startDate, endDate: endDate, category: categoryTextField.text!, message: promiseTextField.text!, amount: price, isPublic: openSwitch.isOn)
        
        guard let addGoalCompleteVC = UIStoryboard.init(name: Identifiers.AddCompleteSB, bundle: nil).instantiateViewController(withIdentifier: AddCompleteVC.className) as? AddCompleteVC else { return }
        navigationController?.pushViewController(addGoalCompleteVC, animated: true)
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
}

// MARK: - UITextFieldDelegate
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
            priceTextField.text = self.numberFormatter(number: price)
        }
    }
    
    /// 목표 금액은 textField를 누르면 초기화 (콤마 넣기 위함)
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == priceTextField {
            priceTextField.text = ""
        }
    }
}

// MARK: - Network
extension AddGoalContentVC {
    
    /// 목표 추가 요청 메서드
    private func postGoal(startDate: String, endDate: String, category: String, message: String, amount: Int, isPublic: Bool) {
        WriteAPI.shared.postGoalAPI(startDate: startDate, endDate: endDate, category: category, message: message, amount: amount, isPublic: isPublic) { networkResult in
            switch networkResult {
            case .success(_):
                break
            case .requestErr:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}
