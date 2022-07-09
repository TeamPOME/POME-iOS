//
//  UITextField+.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/06.
//

import UIKit

extension UITextField {
    
    /// UITextField의 상태를 리턴함
    var isEmpty: Bool {
        return text?.isEmpty ?? true
    }
    
    /// UITextField 왼쪽에 여백 주는 메서드
    func addLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    /// UITextField 오른쪽에 여백 주는 메서드
    func addRightPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    /// 자간 설정 메서드
    func setCharacterSpacing(_ spacing: CGFloat){
        let attributedStr = NSMutableAttributedString(string: self.text ?? "")
        attributedStr.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedStr.length))
        self.attributedText = attributedStr
     }
    
    /// placeholder 색상 설정 메서드
    func setPlaceholderColor(_ placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
    
    /// clear 버튼 커스텀 메서드
    func configureClearBtnWithImage(image : UIImage) {
        let clearBtn = UIButton(type: .custom)
        clearBtn.setImage(image, for: .normal)
        clearBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        clearBtn.contentMode = .scaleAspectFit
        clearBtn.addTarget(self, action: #selector(UITextField.clear(sender:) ), for: .touchUpInside)
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 20))
        rightView.addSubview(clearBtn)
        
        self.rightView = rightView
        self.rightViewMode = .always
    }

    /// 텍스트필드 텍스트 clear 메서드
    @objc func clear(sender : AnyObject) {
        self.text = ""
        sendActions(for: .editingChanged)
    }
}
