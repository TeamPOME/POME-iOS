//
//  SignInVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class SignInVC: BaseVC {
    
    // MARK: Properties
    private let iconImageView = UIImageView().then {
        $0.image = UIImage(named: "middleMarshmallowWhite3D")
        $0.contentMode = .scaleAspectFit
    }
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logoMint")
        $0.contentMode = .scaleAspectFit
    }
    
    private let sloganImageView = UIImageView().then {
        $0.image = UIImage(named: "sloganMint")
        $0.contentMode = .scaleAspectFit
    }
    
    private let kakaoBtn = UIButton().then {
        $0.makeRounded(cornerRadius: 6.adjusted)
        $0.backgroundColor = .kakaoYello
        $0.setTitle("카카오로 시작하기", for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        $0.setTitleColor(.black.withAlphaComponent(0.9), for: .normal)
        $0.setImage(UIImage(named: "icKakao"), for: .normal)
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTapKakaoBtn()
    }
}

// MARK: - UI
extension SignInVC {
    
    private func configureUI() {
        view.addSubviews([iconImageView, logoImageView, sloganImageView, kakaoBtn])
        
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(215)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(230.adjusted)
            $0.height.equalTo(230.adjustedH)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(32)
            $0.centerX.equalTo(iconImageView)
            $0.width.equalTo(170.adjusted)
            $0.height.equalTo(37.adjusted)
        }
        
        sloganImageView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(10)
            $0.width.equalTo(197.adjusted)
            $0.height.equalTo(19.adjustedH)
            $0.centerX.equalTo(logoImageView)
        }
        
        kakaoBtn.snp.makeConstraints {
            $0.top.equalTo(sloganImageView.snp.bottom).offset(83)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(45.adjustedH)
        }
    }
}

// MARK: - Custom Methods
extension SignInVC {
    
    /// 카카오로 시작하기 버튼 tap Action
    private func setTapKakaoBtn() {
        kakaoBtn.press { [weak self] in
            guard let nextVC = UIStoryboard.init(name: Identifiers.SignUpSB, bundle: nil).instantiateViewController(withIdentifier: SignUpNC.className) as? SignUpNC else { return }
            
            nextVC.modalPresentationStyle = .fullScreen
            self?.present(nextVC, animated: true)
        }
    }
}
