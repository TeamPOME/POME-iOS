//
//  PomeBtn.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/07.
//

import UIKit

/**
 - Description:
 POME에서 자주 사용되는 둥근 직사각형 모양의 버튼
 폰트는 Pretendard-Bold: 18pt가 기본이고 이외에는 메서드를 통해 커스텀하여 사용
 
 - Note:
 - setTitle: 버튼 타이틀만 변경
 - makeSubBtn: 투명한 옵션 버튼 만드는 메서드
 - setBtnColors: 버튼 배경, 타이틀 컬러 변경
 - setTitleWithStyle: 버튼 타이틀 스타일 변경
 */
class PomeBtn: UIButton {
    
    // MARK: Properties
    var isDisabled: Bool = false {
        didSet {
            self.backgroundColor = self.isDisabled ? disabledBgColor : normalBgColor
            self.setTitleColor(self.isDisabled ? disabledFontColor : normalFontColor, for: .normal)
            self.isEnabled = !isDisabled
        }
    }
    
    private var normalBgColor: UIColor = .main
    private var disabledBgColor: UIColor = .mint_inactive
    private var normalFontColor: UIColor = .white
    private var disabledFontColor: UIColor = .white
    
    init() {
        super.init(frame: .zero)
        setDefaultStyle()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setDefaultStyle()
    }
    
    // MARK: Private Methods
    
    /// 디폴트 버튼 스타일 설정
    private func setDefaultStyle() {
        self.makeRounded(cornerRadius: 6.adjusted)
        self.titleLabel?.font = .PretendardB(size: 18)
        self.backgroundColor = self.normalBgColor
        self.tintColor = UIColor.main
        self.setTitleColor(self.normalFontColor, for: .normal)
    }
    
    // MARK: Public Methods
    
    /// subBtn 만드는 메서드
    func makeSubBtn() {
        self.normalBgColor = .clear
        self.disabledBgColor = .clear
        self.normalFontColor = .grey_4
        self.disabledFontColor = .grey_4
    }
    
    /// 버튼 컬러 변경 메서드
    func setBtnColors(normalBgColor: UIColor, normalFontColor: UIColor, disabledBgColor: UIColor, disabledFontColor: UIColor) {
        self.normalBgColor = normalBgColor
        self.normalFontColor = normalFontColor
        self.disabledBgColor = disabledBgColor
        self.disabledFontColor = disabledFontColor
    }
    
    
    /// 버튼 타이틀과 스타일 변경 폰트 사이즈 adjusted 적용 메서드
    func setTitleWithStyle(title: String, size: CGFloat, weight: FontWeight = .regular) {
        let font: UIFont
        
        switch weight {
        case .regular:
            font = .PretendardR(size: size.adjusted)
        case .medium:
            font = .PretendardM(size: size.adjusted)
        case .semiBold:
            font = .PretendardSB(size: size.adjusted)
        case .bold:
            font = .PretendardB(size: size.adjusted)
        }
        
        self.titleLabel?.font = font
        self.setTitle(title, for: .normal)
    }
}
