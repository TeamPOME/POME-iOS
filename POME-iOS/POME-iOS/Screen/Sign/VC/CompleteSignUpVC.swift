//
//  CompleteSignUpVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/12.
//

import UIKit
import SnapKit
import Then

class CompleteSignUpVC: BaseVC {

    // MARK: Properties
    private let titleLabel = UILabel().then {
        $0.text = "회원가입 완료!\n친구를 추가해볼까요?"
        $0.font = .PretendardB(size: 24)
        $0.textColor = .grey_9
        $0.numberOfLines = 2
        $0.setLineSpacing(lineSpacing: 5)
        $0.sizeToFit()
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "친구의 소비 기록을 확인하고\n서로 응원할 수 있어요"
        $0.font = .PretendardM(size: 14)
        $0.textColor = .grey_5
        $0.numberOfLines = 2
        $0.setLineSpacing(lineSpacing: 5)
        $0.sizeToFit()
    }
    
    private let iconImageView = UIImageView().then {
        $0.image = UIImage(named: "3DTrashCanMint100")
        $0.contentMode = .scaleAspectFit
    }
    
    private let cancelBtn = PomeBtn().then {
        $0.makeSubBtn()
        $0.isDisabled = false
        $0.setTitle("다음에 할래요", for: .normal)
    }
    
    private let confirmBtn = PomeBtn().then {
        $0.setTitle("추가할래요", for: .normal)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTapCancelBtn()
        setTapConfirmBtn()
    }
}

// MARK: - UI
extension CompleteSignUpVC {
    
    private func configureUI() {
        view.addSubviews([titleLabel, subTitleLabel, iconImageView, cancelBtn, confirmBtn])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(56)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(80)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(53)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(52)
            $0.width.equalTo(iconImageView.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        confirmBtn.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
        
        cancelBtn.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(103)
            $0.bottom.equalTo(confirmBtn.snp.top).offset(-12)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
    }
}

// MARK: - Custom Methods
extension CompleteSignUpVC {
    
    /// 다음에 할래요 버튼 tap Action 설정 메서드
    private func setTapCancelBtn() {
        cancelBtn.press { [weak self] in
            guard let self = self else { return }
            
            let pomeTBC = PomeTBC()
            pomeTBC.modalPresentationStyle = .fullScreen
            self.present(pomeTBC, animated: true, completion: nil)
        }
    }
    
    /// 추가할래요 버튼 tap Action 설정 메서드
    private func setTapConfirmBtn() {
        confirmBtn.press { [weak self] in
            guard let self = self else { return }
            guard let nextVC = UIStoryboard.init(name: Identifiers.AddFriendSB, bundle: nil).instantiateViewController(withIdentifier: AddFriendVC.className) as? AddFriendVC else { return }
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
