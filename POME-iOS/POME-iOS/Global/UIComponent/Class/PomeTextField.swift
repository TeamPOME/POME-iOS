//
//  PomeTextField.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/09.
//

import UIKit
import Then

enum TextFieldState {
    case defaultStyle
    case withClearBtn
    case withRightBtn
}

class PomeTextField: UITextField {
    
    let rightBtn = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        $0.setImage(UIImage(named: "icSearch20"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - UI
extension PomeTextField {
    
    /// 기본 텍스트 필드
    private func configureDefaulStyle() {
        self.makeRounded(cornerRadius: 6.adjusted)
        self.font = .PretendardM(size: 14)
        self.addLeftPadding(16)
        self.backgroundColor = .grey_0
        self.tintColor = .main
        self.borderStyle = .none
    }
    
    /// 오른쪽에 clear 버튼이 있는 텍스트 필드
    private func configureWithClearBtn() {
        self.makeRounded(cornerRadius: 6.adjusted)
        self.font = .PretendardM(size: 16)
        self.addLeftPadding(16)
        self.backgroundColor = .grey_0
        self.tintColor = .main
        self.borderStyle = .none
        self.configureClearBtnWithImage(image: UIImage(named: "icDelete20")!)
    }
    
    /// 오른쪽에 커스텀 버튼이 있는 텍스트 필드
    private func configureWithRightBtn() {
        self.makeRounded(cornerRadius: 6.adjusted)
        self.font = .PretendardM(size: 16)
        self.addLeftPadding(16)
        self.backgroundColor = .grey_0
        self.tintColor = .main
        self.borderStyle = .none
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 20))
        rightView.addSubview(rightBtn)
        
        self.rightView = rightView
        self.rightViewMode = .always
    }
}

// MARK: - Public Methods
extension PomeTextField {
    
    /// placeholder 설정하는 메서드
    func configurePlaceholder(placeholder: String) {
        self.placeholder = placeholder
        self.setPlaceholderColor(.grey_5)
    }
}

// MARK: - Custom Methods
extension PomeTextField {
    
    /// state에 따라 커스텀 텍스트필드 UI 스타일을 지정하는 메서드
    func setTextFieldStyle(state: TextFieldState) {
        switch state.self {
        case .defaultStyle:
            configureDefaulStyle()
        case .withClearBtn:
            configureWithClearBtn()
        case .withRightBtn:
            configureWithRightBtn()
        }
    }
}
