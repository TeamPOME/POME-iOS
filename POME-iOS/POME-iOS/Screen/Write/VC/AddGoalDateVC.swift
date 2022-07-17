//
//  AddGoalDateVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/15.
//

import UIKit

class AddGoalDateVC: BaseVC {
    
    // MARK: Properties
    var isFirstCalendar: Bool = true
    
    // MARK: IBOutlet
    @IBOutlet weak var naviBar: PomeNaviBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startCalendarBtn: UIButton!
    @IBOutlet weak var endCalendarBtn: UIButton!
    @IBOutlet weak var confirmBtn: PomeBtn!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTapBackBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideTabbar()
    }
    
    // MARK: IBAction
    @IBAction func tapStartCalendar(_ sender: UIButton) {
        isFirstCalendar = true
        showHalfModalVC()
    }
    
    @IBAction func tapEndCalendar(_ sender: UIButton) {
        isFirstCalendar = false
        showHalfModalVC()
    }
    
    @IBAction func tapConfirmBtn(_ sender: UIButton) {
        
        // TODO: - 화면 전환 및 데이터 전달 필요
    }
}

// MARK: - Custom Methods
extension AddGoalDateVC {
    
    private func configureUI() {
        naviBar.setNaviStyle(state: .whiteBackDefault)
        titleLabel.setLineSpacing(lineSpacing: 4)
        titleLabel.textAlignment = .left
        endCalendarBtn.isEnabled = false
        confirmBtn.setTitle("선택했어요", for: .normal)
        confirmBtn.isDisabled = true
    }
    
    private func setTapBackBtn() {
        naviBar.backBtn.press { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - @objc
extension AddGoalDateVC {
    
    /// 만들어 둔 HalfModalVC 보여주는 함수
    @objc func showHalfModalVC() {
        let halfModalVC = CalendarVC()
        halfModalVC.delegate = self
        
        /// 선택된 값 유무에 따라 시작 날짜 전달 선택하지 않았으면 오늘 날짜 전달
        if startDateLabel.textColor == .grey_9 {
            halfModalVC.startDate = self.getStringToDate(string: startDateLabel.text!)
        } else {
            halfModalVC.startDate = Date()
        }
        
        /// 선택된 값 유무에 따라 종료 날짜 전달 선택하지 않았으면 시작 날짜의 다음 날짜 전달
        if endDateLabel.textColor == .grey_9 {
            halfModalVC.endDate = self.getStringToDate(string: endDateLabel.text!)
        } else {
            guard let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: self.getStringToDate(string: startDateLabel.text!)) else { return }
            halfModalVC.endDate = nextDay
        }
        
        halfModalVC.isStartCalendar = isFirstCalendar
        halfModalVC.modalPresentationStyle = .custom
        halfModalVC.transitioningDelegate = self
        self.present(halfModalVC, animated: true, completion: nil)
    }
}

// MARK: - DeliveryDateDelegate
extension AddGoalDateVC: DeliveryDateDelegate{
    
    /// 받아온 데이터로 날짜 레이블 변경
    func deliveryDate(startDate: Date, endDate: Date, isStartDate: Bool) {
        if isStartDate {
            startDateLabel.text = self.getSelectedDate(date: startDate)
            startDateLabel.textColor = .grey_9
            endCalendarBtn.isEnabled = true
            
            /// 이미 종료 날짜를 정한 후 다시 시작 날짜를 선택할 경우 텍스트 기본으로 변경
            if endDateLabel.textColor == .grey_9 {
                endDateLabel.text = "목표 종료 날짜를 선택해주세요"
                endDateLabel.textColor = .grey_5
            }
        } else {
            endDateLabel.text = self.getSelectedDate(date: endDate)
            endDateLabel.textColor = .grey_9
        }
        
        /// 날짜 두 개 다 선택한 경우 다음으로 넘어가는 버튼 활성화
        confirmBtn.isDisabled = !(startDateLabel.textColor == .grey_9 && endDateLabel.textColor == .grey_9)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension AddGoalDateVC: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let halfModalVC = PomeHalfModalVC(presentedViewController: presented, presenting: presenting)
        
        /// HalfModalView의 높이 지정
        halfModalVC.modalHeight = 448
        return halfModalVC
    }
}
