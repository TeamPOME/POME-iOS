//
//  SignInVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/15.
//

import UIKit
import SnapKit
import Then
import KakaoSDKCommon
import KakaoSDKUser

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
        $0.backgroundColor = .kakaoYellow
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
            
            // 카카오톡 설치 여부 확인
            if UserApi.isKakaoTalkLoginAvailable() {
                self?.loginWithKakaoApp()
            } else {
                self?.loginWithWeb()
            }
        }
    }
    
    /// 프로필 생성 뷰로 화면전환하는 메서드
    private func presentMakeProfileVC() {
        guard let nextVC = UIStoryboard.init(name: Identifiers.SignUpSB, bundle: nil).instantiateViewController(withIdentifier: SignUpNC.className) as? SignUpNC else { return }
        
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    /// 메인으로 화면전환하는 메서드
    private func presentMain() {
        let pomeTBC = PomeTBC()
        pomeTBC.modalPresentationStyle = .fullScreen
        self.present(pomeTBC, animated: true, completion: nil)
    }
    
    /// UserDefaults값 설정하는 함수
    private func setUserDefaultsValue(data: SignInResModel) {
        if data.accessToken != nil {
            UserDefaults.standard.set("Bearer \(data.accessToken ?? "")", forKey: UserDefaults.Keys.accessToken)
        }
        UserDefaults.standard.set(data.refreshToken ?? "", forKey: UserDefaults.Keys.refreshToken)
        UserDefaults.standard.set(data.id ?? -1, forKey: UserDefaults.Keys.userID)
    }
}

// MARK: - Network
extension SignInVC {
    
    /// 앱으로 로그인
    private func loginWithKakaoApp() {
        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
            if error != nil {
                print("login fail")
            } else {
                if let accessToken = oauthToken?.accessToken {
                    UserDefaults.standard.set(accessToken, forKey: UserDefaults.Keys.kakaoToken)
                    self.requestKakaoLogin()
                }
            }
        }
    }
    
    /// 앱 미설치 기기일 경우 웹으로 로그인
    private func loginWithWeb() {
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if error != nil {
                print("login fail")
            } else {
                if let accessToken = oauthToken?.accessToken {
                    UserDefaults.standard.set(accessToken, forKey: UserDefaults.Keys.kakaoToken)
                    self.requestKakaoLogin()
                }
            }
        }
    }
    
    /// 카카오 로그인 요청 메서드
    private func requestKakaoLogin() {
        SignAPI.shared.requestLoginAPI() { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? SignInResModel {
                    
                    /// 없는 유저 -> 회원가입
                    if data.type == "signup" {
                        UserDefaults.standard.set(data.uuid ?? "", forKey: UserDefaults.Keys.uuid)
                        self.presentMakeProfileVC()
                        
                    /// 이미 가입한 유저 -> 바로 로그인
                    } else {
                        self.setUserDefaultsValue(data: data)
                        self.presentMain()
                    }
                }
            case .requestErr:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}
