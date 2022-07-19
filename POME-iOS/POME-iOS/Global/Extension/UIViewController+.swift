//
//  UIViewController+.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/06.
//

import UIKit

extension UIViewController {
    
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    /**
     - Description: 화면 터치시 작성 종료
     */
    /// 화면 터치시 작성 종료하는 메서드
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /**
     - Description: 화면 터치시 키보드 내리는 Extension
     */
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /**
     - Description: 키보드가 화면을 가릴 때 처리하기 위한 노티피케이션 추가
     */
    
    // 노티피케이션을 추가하는 메서드
    func addKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            if self.view.frame.origin.y == 0 {
                
                /// naviBar 만큼 올림
                self.view.frame.origin.y -= 44.adjustedH
            }
        }
    }

    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            if self.view.frame.origin.y != 0 {
                
                /// naviBar 만큼 내림
                self.view.frame.origin.y += 44.adjustedH
            }
        }
    }
    
    /**
     - Description: Alert
     */
    /// 확인 버튼 1개, 취소 버튼 1개 ActionSheet 메서드
    func makeOneAlertWithCancel(okTitle: String, okStyle: UIAlertAction.Style = .default,
                                cancelTitle: String = "취소",
                                okAction : ((UIAlertAction) -> Void)?, cancelAction : ((UIAlertAction) -> Void)? = nil,
                                completion : (() -> Void)? = nil) {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alertViewController = UIAlertController(title: nil, message: nil,
                                                    preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: okTitle, style: okStyle, handler: okAction)
        alertViewController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    /**
     - Description: Alert
     */
    /// 확인 버튼 2개, 취소 버튼 1개 ActionSheet 메서드
    func makeTwoAlertWithCancel(okTitle: String, okStyle: UIAlertAction.Style = .default,
                                secondOkTitle: String, secondOkStyle: UIAlertAction.Style = .default,
                                cancelTitle: String = "취소",
                                okAction : ((UIAlertAction) -> Void)?, secondOkAction : ((UIAlertAction) -> Void)?, cancelAction : ((UIAlertAction) -> Void)? = nil,
                                completion : (() -> Void)? = nil) {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alertViewController = UIAlertController(title: nil, message: nil,
                                                    preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: okTitle, style: okStyle, handler: okAction)
        alertViewController.addAction(okAction)
        
        let secondOkAction = UIAlertAction(title: secondOkTitle, style: secondOkStyle, handler: secondOkAction)
        alertViewController.addAction(secondOkAction)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    /**
     - Description:
     VC나 View 내에서 해당 함수를 호출하면, 햅틱이 발생하는 메서드입니다.
     버튼을 누르거나 유저에게 특정 행동이 발생했다는 것을 알려주기 위해 다음과 같은 햅틱을 활용합니다.
     
     - parameters:
     - degree: 터치의 세기 정도를 정의. 보통은 medium,light를 제일 많이 활용합니다.
     */
    func makeVibrate(degree : UIImpactFeedbackGenerator.FeedbackStyle = .medium)
    {
        let generator = UIImpactFeedbackGenerator(style: degree)
        generator.impactOccurred()
    }
    
    /**
     - Description:
     날짜를 포멧 형태에 따라 변경해주는 메서드입니다.
     */
    
    /// 년, 월 형식으로 리턴하는 함수
    func getMonthDate(date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy년 M월"
        return df.string(from: date)
    }
    
    /// yyyy.MM.dd 형식으로 리턴하는 함수
    func getSelectedDate(date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy.MM.dd"
        return df.string(from: date)
    }
    
    /// yyyy.MM.dd 형식의 날짜를 Date형으로 바꿔주는 함수
    func getStringToDate(string: String) -> Date {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy.MM.dd"
        return df.date(from: string) ?? Date()
    }
    
    /**
     - Description:
     숫자에 세 자리마다 콤마를 넣어주는 메서드 입니다.
     */
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
}
