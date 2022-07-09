//
//  PomeTextField.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/09.
//

import UIKit

enum TextFieldState {
    case withClearBtn
}

class PomeTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension PomeTextField {
    
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
        case .withClearBtn:
            configureWithClearBtn()
        }
    }
}
