//
//  AddGoalDateVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/15.
//

import UIKit

class AddGoalDateVC: BaseVC {
    
    // MARK: Properties
    var startDate: Date = Date()
    var endDate: Date = Date()

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
        setTapBackBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideTabbar()
    }
    
    // MARK: IBAction
    @IBAction func tapStartCalendar(_ sender: UIButton) {
        showHalfModalVC()
    }

    @IBAction func tapEndCalendar(_ sender: UIButton) {
        showHalfModalVC()
    }
    
    @IBAction func tapConfirmBtn(_ sender: UIButton) {
        
        // TODO: - 서버 통신 필요
    }
}

// MARK: - Custom Methods
extension AddGoalDateVC {
    
    private func configureUI() {
        naviBar.setNaviStyle(state: .whiteBackDefault)
        titleLabel.setLineSpacing(lineSpacing: 4)
        titleLabel.textAlignment = .left
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
        halfModalVC.modalPresentationStyle = .custom
        halfModalVC.transitioningDelegate = self
        self.present(halfModalVC, animated: true, completion: nil)
    }
}

// MARK: - DeliveryDateDelegate
extension AddGoalDateVC: DeliveryDateDelegate{
    
    /// 받아온 데이터로 날짜 레이블 변경
    func deliveryDate(date: Date, isStartDate: Bool) {
        if isStartDate {
            startDate = date
            startDateLabel.text = self.getSelectedDate(date: date)
            startDateLabel.textColor = .grey_9
        } else {
            endDate = date
            endDateLabel.text = self.getSelectedDate(date: date)
            endDateLabel.textColor = .grey_9
        }
        
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
