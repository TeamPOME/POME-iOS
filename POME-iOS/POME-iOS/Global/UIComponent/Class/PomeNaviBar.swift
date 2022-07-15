//
//  PomeNaviBar.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/08.
//

import UIKit
import SnapKit
import Then

enum NaviState {
    case whiteBackDefault
    case greyBackDefault
    case greyWithRightBtn
    case whiteWithTitle
    case whiteBackWithTitle
}

/**
 POME에서 자주 사용되는 네비게이션바 UIView
 - Note:
 - whiteBackDefault: 흰색 배경 + 뒤로가기 버튼
 - greyBackDefault: 회색 배경 + 뒤로가기 버튼
 - greyWithRightNotiBtn: 회색 배경 + 우측 버튼
 - whiteWithTitle: 흰색 배경 + 중앙 타이틀
 - whiteBackWithTitle: 흰색 배경 + 뒤로가기 버튼 + 중앙 타이틀
 
 - configureTitleLabel: titleLabel 텍스트 변경
 - configureRightCustomBtn: 우측 커스텀 버튼 이미지 변경
 - setNaviStyle: NaviState를 지정해 해당 스타일로 네비바를 구성
 */
class PomeNaviBar: UIView {
    
    // MARK: Properties
    private (set) lazy var whiteBackView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private (set) lazy var greyBackView = UIView().then {
        $0.backgroundColor = .grey_0
    }
    
    private (set) lazy var backBtn = UIButton().then {
        $0.setImgByName(name: "icArrowLeft24", selectedName: nil)
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var rightCustomBtn = UIButton().then {
        $0.setImgByName(name: "icAlarmAll", selectedName: nil)
        $0.contentMode = .scaleAspectFit
    }
    
    private (set) lazy var titleLabel = UILabel().then {
        $0.setLabel(text: "타이틀", color: .grey_9, size: 14, weight: .semiBold)
    }
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}

// MARK: - UI
extension PomeNaviBar {
    
    /// 흰색 배경 + 뒤로가기 버튼 UI를 구성하는 메서드
    private func configureWhiteBackDefaultUI() {
        self.addSubviews([whiteBackView, backBtn])
        
        whiteBackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(backBtn.snp.height).multipliedBy(1.0 / 1.0)
        }
    }
    
    /// 회색 배경 + 뒤로가기 버튼 UI를 구성하는 메서드
    private func configureGreyBackDefault() {
        self.addSubviews([greyBackView, backBtn])
        
        greyBackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(backBtn.snp.height).multipliedBy(1.0 / 1.0)
        }
    }
    
    /// 회색 배경 + 우측 버튼 UI를 구성하는 메서드
    private func configureGreyWithRightBtn() {
        self.addSubviews([greyBackView, rightCustomBtn])
        
        greyBackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        rightCustomBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(rightCustomBtn.snp.height).multipliedBy(1.0 / 1.0)
        }
    }
    
    /// 흰색 배경 + 타이틀 UI를 구성하는 메서드
    private func configureWhiteWithTitle() {
        self.addSubviews([whiteBackView, titleLabel])
        
        whiteBackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    /// 흰색 배경 + 뒤로가기 버튼 + 타이틀 UI를 구성하는 메서드
    private func configureWhiteBackWithTitle() {
        self.addSubviews([whiteBackView, backBtn, titleLabel])
        
        whiteBackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(backBtn.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backBtn)
        }
    }
}

// MARK: - Public Methods
extension PomeNaviBar {
    
    /// 커스텀 네비 바 타이틀 설정하는 메서드
    func configureTitleLabel(title: String) {
        self.titleLabel.text = title
    }
    
    /// 커스텀 네비 바 우측 버튼 이미지 설정하는 메서드
    func configureRightCustomBtn(imgName: String) {
        rightCustomBtn.setImgByName(name: imgName, selectedName: nil)
    }
}

// MARK: - Custom Methods
extension PomeNaviBar {
    
    /// state에 따라 커스텀 네비 UI 스타일을 지정하는 메서드
    func setNaviStyle(state: NaviState) {
        switch state.self {
            
        case .whiteBackDefault:
            configureWhiteBackDefaultUI()
        case .greyBackDefault:
            configureGreyBackDefault()
        case .greyWithRightBtn:
            configureGreyWithRightBtn()
        case .whiteWithTitle:
            configureWhiteWithTitle()
        case .whiteBackWithTitle:
            configureWhiteBackWithTitle()
        }
    }
}
