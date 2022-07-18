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
    var isStartCalendar: Bool = true
    
    /// 목표 추가 메인뷰에서 받아 올 시작 날짜와 종료 날짜
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    /// delegate 선언
    var deliveryDateDelegate: DeliveryDateDelegate?
    
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
        if isStartCalendar {
            deliveryDateDelegate?.deliveryDate(selectedDate: startDate, isStartDate: isStartCalendar)
        } else {
            deliveryDateDelegate?.deliveryDate(selectedDate: endDate, isStartDate: isStartCalendar)
        }
        self.dismiss(animated: true)
    }
}

// MARK: - UI
extension CalendarVC {
    
    private func configureUI() {
        
        selectBtn.setTitle("선택했어요", for: .normal)
        
        /// 시작 달로 헤더 레이블 설정
        if isStartCalendar {
            headerLabel.text = self.getMonthDate(date: startDate)
        } else {
            headerLabel.text = self.getMonthDate(date: endDate)
        }
        
        /// 캘린더 좌우 버튼 활성화 여부
        if isStartCalendar {
            
            /// 시작 날짜 캘린더일때 가능한 달은 오늘 기준 현재달 or 다음달 -> 현재달이면 왼쪽 버튼 비활성화, 다음달이면 오른쪽 버튼 비활성화
            toLeftBtn.isEnabled = !(Calendar.current.component(.month, from: Date()) == Calendar.current.component(.month, from: startDate))
            toRightBtn.isEnabled = (Calendar.current.component(.month, from: Date()) == Calendar.current.component(.month, from: startDate))
        } else {
            
            /// 종료 날짜 캘린더일때 가능한 달은 start달 기준 start달 or 다음달 -> start달이면 왼쪽버튼 비활성화, 다음달이면 오른쪽 버튼 비활성화
            toLeftBtn.isEnabled = !(Calendar.current.component(.month, from: startDate) == Calendar.current.component(.month, from: endDate))
            toRightBtn.isEnabled = (Calendar.current.component(.month, from: startDate) == Calendar.current.component(.month, from: endDate))
        }
        
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
        
        // 달력의 요일 글자 바꾸기
        calendar.locale = Locale(identifier: "ko_KR")
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
        
        self.currentPage = isStartCalendar ? cal.date(byAdding: dateComponents, to: self.currentPage ?? self.startDate) : cal.date(byAdding: dateComponents, to: self.currentPage ?? self.endDate)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)

        toLeftBtn.isEnabled.toggle()
        toRightBtn.isEnabled.toggle()
    }
}

// MARK: - FSCalendarDelegate
extension CalendarVC: FSCalendarDelegate {
    
    /// 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if isStartCalendar {
            startDate = date
        } else {
            endDate = date
        }
    }
    
    /// 캘린더 달이 바뀌면 해당 yyyy월 m월로 헤더 변경
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        headerLabel.text = self.getMonthDate(date: calendar.currentPage)
    }
}

// MARK: - FSCalendarDataSource
extension CalendarVC: FSCalendarDataSource {
    
    /// 오늘 이전 or 시작 날짜 이전은 선택 불가능
    func minimumDate(for calendar: FSCalendar) -> Date {
        if isStartCalendar {
            calendar.select(startDate)
            return Date()
        } else {
            calendar.select(endDate)
            guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: startDate) else { return Date() }
            return tomorrow
        }
    }
    
    /// 오늘 or 시작 날짜로부터 한 달 까지만 설정 가능
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
