//
//  CalendarVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/16.
//

import UIKit
import FSCalendar

class CalendarVC: BaseVC {
    
    // MARK: Properties
    private var currentPage: Date?
    var selectedDate: Date = Date()
    var isStartCalendar: Bool = true
    
    /// 목표 추가 메인뷰에서 받아 올 시작 날짜와 종료 날짜
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    /// delegate 및 클로저 선언
    var delegate: DeliveryDateDelegate?
    
    // MARK: IBOutlet
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var toLeftBtn: UIButton!
    @IBOutlet weak var toRightBtn: UIButton!
    @IBOutlet weak var selectBtn: PomeBtn!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDelegate()
    }
    
    // MARK: IBAction
    @IBAction func prevBtnTapped(_ sender: UIButton) {
        scrollCurrentPage(isPrev: true)
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        scrollCurrentPage(isPrev: false)
    }
    
    @IBAction func tapSelectBtn(_ sender: UIButton) {
        delegate?.deliveryDate(date: selectedDate, isStartDate: isStartCalendar)
        self.dismiss(animated: true)
    }
}

// MARK: - UI
extension CalendarVC {
    
    private func configureUI() {
        
        selectBtn.setTitle("선택했어요", for: .normal)
        
        /// 현재 달이기 때문에 이전 달로는 못감
        toLeftBtn.isEnabled = false
        toRightBtn.isEnabled = true
        
        /// 시작 달로 페이지 설정
        headerLabel.text = self.getMonthDate(date: startDate)
        
        /// 스크롤 안되게
        calendar.scrollEnabled = false
        
        /// 헤더 높이 설정
        calendar.headerHeight = 0
        
        /// 월~일 글자 폰트 및 사이즈, 색상 지정
        calendar.appearance.weekdayFont = .PretendardSB(size: 14)
        calendar.appearance.weekdayTextColor = .grey_5
        
        /// 숫자들 글자 폰트 및 사이즈, 색상 지정
        calendar.appearance.titleFont = .PretendardSB(size: 14)
        calendar.appearance.titleDefaultColor = .grey_9
        calendar.appearance.titleWeekendColor = .grey_9
        
        /// 오늘 배경, 글씨 색상 변경
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = (isStartCalendar) ? .grey_9 : .grey_5
        
        /// 이전, 이후 달 날짜 제거
        calendar.placeholderType = .none
    }
}

// MARK: - Custom Methods
extension CalendarVC {
    
    private func setDelegate() {
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    /// 스크롤한 페이지를 가져온다.
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.startDate)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
}

// MARK: - FSCalendarDelegate
extension CalendarVC: FSCalendarDelegate {
    
    /// 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
    }
    
    /// 현재 페이지가 startDate 달이면 < 버튼 비활성화, 다음 달이면 > 비활성화
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        headerLabel.text = self.getMonthDate(date: calendar.currentPage)
        toRightBtn.isEnabled.toggle()
        toLeftBtn.isEnabled.toggle()
    }
}

// MARK: - FSCalendarDataSource
extension CalendarVC: FSCalendarDataSource {
    
    /// 오늘 이전은 선택 불가능
    func minimumDate(for calendar: FSCalendar) -> Date {
        
        if isStartCalendar {
            calendar.select(startDate)
            return Date()
        } else {
            guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: startDate) else { return Date() }
            calendar.select(tomorrow)
            return tomorrow
        }
    }
    
    /// 한 달 까지만 설정 가능
    func maximumDate(for calendar: FSCalendar) -> Date {
        
        if isStartCalendar {
            guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date()) else { return Date() }
            return nextMonth
        } else {
            guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: startDate) else { return Date() }
            return nextMonth
        }
    }
}

// MARK: - FSCalendarDelegateAppearance
extension CalendarVC: FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return .sub
    }
}
