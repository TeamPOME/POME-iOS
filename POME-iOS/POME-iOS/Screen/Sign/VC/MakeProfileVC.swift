//
//  MakeProfileVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/11.
//

import UIKit
import SnapKit
import Then

class MakeProfileVC: BaseVC {
    
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
        $0.returnKeyType = .done
        $0.keyboardType = .namePhonePad
        $0.configurePlaceholder(placeholder: "한글, 영어, 숫자 사용가능, 최대 10자")
    }
    
    private let nicknameCheckLabel = UILabel().then {
        $0.textColor = .main
        $0.font = .PretendardM(size: 14)
        $0.text = "멋진 닉네임이네요!"
        $0.isHidden = true
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
    
    private let imagePicker = UIImagePickerController()
    
    private var isPicked = false
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTextField()
        setTapChooseImageBtn()
        setTapConfirmBtn()
        setImagePickerDelegate()
        setNaviBar()
    }
}

// MARK: - UI
extension MakeProfileVC {
    
    private func configureUI() {
        view.addSubviews([titleLabel, profileImageView, plusImageView, chooseImageBtn, nicknameCheckLabel, nicknameTextField, confirmBtn, explainLabel])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(56)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(49.adjustedH)
            $0.width.equalTo(149.adjusted)
            $0.height.equalTo(149.adjustedH)
            $0.centerX.equalToSuperview()
        }
        
        plusImageView.snp.makeConstraints {
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
            $0.top.equalTo(profileImageView.snp.bottom).offset(40.adjustedH)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
        
        nicknameCheckLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            $0.leading.equalTo(nicknameTextField.snp.leading)
        }
        
        confirmBtn.snp.makeConstraints {
            
            /// SE 기기대응
            if screenHeight == 667 {
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(34)
                $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
                $0.height.equalTo(50)
            } else {
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
                $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
                $0.height.equalTo(50)
            }
        }
        
        explainLabel.snp.makeConstraints {
            $0.bottom.equalTo(confirmBtn.snp.top).offset(-32)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: - Custom Methods
extension MakeProfileVC {
    
    /// textField 설정 메서드
    private func setTextField() {
        nicknameTextField.delegate = self
        nicknameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    /// 프로필 버튼 tap Action 설정 메서드
    private func setTapChooseImageBtn() {
        chooseImageBtn.press { [weak self] in
            if !(self?.isPicked ?? false) {
                self?.makeTwoAlertWithCancel(okTitle: "사진앨범", secondOkTitle: "카메라", okAction: { _ in
                    self?.openAlbum()
                }, secondOkAction: { _ in
                    self?.openCamera()
                })
            } else {
                self?.makeTwoAlertWithCancel(okTitle: "수정", secondOkTitle: "삭제", okAction: { _ in
                    self?.openAlbum()
                }, secondOkAction: { _ in
                    self?.profileImageView.image = UIImage(named: "userProfileEmpty160")
                    self?.isPicked = false
                })
            }
        }
    }
    
    /// 만들었어요 버튼 tap Action 설정 메서드
    func setTapConfirmBtn() {
        
        confirmBtn.press { [weak self] in
            guard let self = self else { return }
            
            self.requestKakaoSignUp(url: APIConstants.baseURL + "/auth", parameters: ["social" : "kakao", "uuid" : UserDefaults.standard.string(forKey: UserDefaults.Keys.uuid) ?? "", "nickname" : self.nicknameTextField.text ?? ""], data: self.profileImageView.image?.pngData() ?? Data(), filename: "file", mimeType: "image/png")
        }
    }
    
    /// 사진앨범 불러오는 메소드
    private func openAlbum() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: false, completion: nil)
    }
    
    /// 카메라 불러오는 메소드
    private func openCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            present(imagePicker, animated: false, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    /// UserDefaults에 값 저장하는 메서드
    private func setUserDefaultsValue(data: SignUpResModel) {
        UserDefaults.standard.set(data.accessToken, forKey: UserDefaults.Keys.accessToken)
        UserDefaults.standard.set(data.refreshToken, forKey: UserDefaults.Keys.refreshToken)
        UserDefaults.standard.set(data.id, forKey: UserDefaults.Keys.userID)
    }
    
    /// 회원가입 완료 뷰로 화면 전환하는 메서드
    private func presentCompleteSignUpVC() {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: CompleteSignUpVC.className) as? CompleteSignUpVC else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    /// 오른쪽으로 swipe시 뒤로가기 활성화 여부
      private func setNaviBar() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
      }
}

// MARK: @objc
extension MakeProfileVC {
    
    @objc
    func textFieldDidChange(_ sender: Any?) {
        confirmBtn.isDisabled = nicknameTextField.isEmpty
        nicknameCheckLabel.isHidden = nicknameTextField.isEmpty
        nicknameCheckLabel.text = "멋진 닉네임이네요!"
        nicknameCheckLabel.textColor = .main
    }
}

// MARK: - UITextFieldDelegate
extension MakeProfileVC: UITextFieldDelegate {
    
    /// done 키 터치 시 키보드 내려가도록
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nicknameTextField.resignFirstResponder()
        
        return true
    }
    
    /// 글자수 10자로 제한 하는 메서드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = nicknameTextField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return changedText.count < 11
    }
}

// MARK: - UINavigationControllerDelegate
extension MakeProfileVC: UINavigationControllerDelegate {
    
    /// 대리자 위임 메서드
    private func setImagePickerDelegate() {
        imagePicker.delegate = self
    }
}

// MARK: - UIImagePickerControllerDelegate
extension MakeProfileVC: UIImagePickerControllerDelegate {
    
    /// 이미지 선택하는 함수
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        profileImageView.image = image
        isPicked = true
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Network
extension MakeProfileVC {
    
    /// 카카오 회원가입 요청 메서드
    private func requestKakaoSignUp(url: String, parameters: [String: String], data: Data, filename: String, mimeType: String) {
        SignUpAPI.shared.requestPOSTWithMultipartform(url: url, parameters: parameters, data: data, filename: filename, mimeType: mimeType) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? SignUpResModel {
                    DispatchQueue.main.async {
                        self.nicknameCheckLabel.textColor = .main
                        self.nicknameCheckLabel.text = "멋진 닉네임이네요!"
                        self.setUserDefaultsValue(data: data)
                        self.presentCompleteSignUpVC()
                    }
                }
            case .requestErr:
                DispatchQueue.main.async {
                    self.nicknameCheckLabel.textColor = .red
                    self.nicknameCheckLabel.text = "사용할 수 없는 닉네임이에요"
                    self.confirmBtn.isDisabled = true
                }
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}

