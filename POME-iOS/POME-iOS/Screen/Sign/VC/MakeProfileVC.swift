//
//  MakeProfileVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/11.
//

import UIKit
import SnapKit
import Then

class MakeProfileVC: UIViewController {
    
    // MARK: Properties
    private let titleLabel = UILabel().then {
        $0.text = "나만의 프로필을\n만들어볼까요?"
        $0.numberOfLines = 2
        $0.setLineSpacing(lineSpacing: 5)
        $0.font = .PretendardB(size: 24)
        $0.textColor = .grey_9
        $0.sizeToFit()
    }
    
    private let profileImageView = PomeMaskedImageView().then {
        $0.image = UIImage(named: "userProfileEmpty160")
        $0.maskImage = UIImage(named: "userProfileEmpty160")
    }
    
    private let plusImageView = UIImageView().then {
        $0.image = UIImage(named: "icPlus24")
    }
    
    private let chooseImageBtn = UIButton()
    
    private let nicknameTextField = PomeTextField().then {
        $0.setTextFieldStyle(state: .withClearBtn)
        $0.configurePlaceholder(placeholder: "영어, 한국어 최대 10자 이내 입력")
    }
    
    private let explainLabel = UILabel().then {
        $0.text = "입력한 정보는 회원을 식별하고 친구간 커뮤니케이션을 위한\n동의 목적으로만 사용되며 포미 이용기간 동안 보관돼요"
        $0.numberOfLines = 2
        $0.setLineSpacing(lineSpacing: 5)
        $0.font = .PretendardM(size: 12)
        $0.textColor = .grey_5
        $0.textAlignment = .center
        $0.sizeToFit()
    }
    
    private let confirmBtn = PomeBtn().then {
        $0.isDisabled = true
        $0.setTitle("만들었어요", for: .normal)
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDelegate()
    }
    
}

// MARK: - UI
extension MakeProfileVC {
    
    private func configureUI() {
        view.addSubviews([titleLabel, profileImageView, plusImageView, chooseImageBtn, nicknameTextField, confirmBtn, explainLabel])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(56)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(49)
            $0.width.height.equalTo(149)
            $0.centerX.equalToSuperview()
        }
        
        plusImageView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top).inset(123)
            $0.leading.equalTo(profileImageView.snp.leading).inset(131)
            $0.trailing.equalTo(profileImageView.snp.trailing)
            $0.bottom.equalTo(profileImageView.snp.bottom).inset(13)
            $0.width.height.equalTo(24)
        }
        
        chooseImageBtn.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.leading.equalTo(profileImageView.snp.leading)
            $0.trailing.equalTo(profileImageView.snp.trailing)
            $0.bottom.equalTo(profileImageView.snp.bottom)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }

        confirmBtn.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
        
        explainLabel.snp.makeConstraints {
            $0.bottom.equalTo(confirmBtn.snp.top).offset(-32)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: - Custom Methods
extension MakeProfileVC {
    
    private func setDelegate() {
        nicknameTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate
extension MakeProfileVC: UITextFieldDelegate {
    
    /// 글자수 10자로 제한 하는 메서드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = nicknameTextField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return changedText.count < 11
    }
}
