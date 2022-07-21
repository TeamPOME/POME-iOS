//
//  AddFriendVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/14.
//

import UIKit
import SnapKit
import Then

class AddFriendVC: BaseVC {
    
    // MARK: Properties
    var naviBar = PomeNaviBar().then {
        $0.setNaviStyle(state: .whiteWithTitle)
        $0.configureTitleLabel(title: "친구 추가")
    }
    
    private let searchBarTextField = PomeTextField().then {
        $0.setTextFieldStyle(state: .withRightBtn)
        $0.configurePlaceholder(placeholder: "친구의 닉네임을 검색해보세요")
        $0.returnKeyType = .done
    }
    
    private let profileTV = UITableView()
    
    private let completeBtn = PomeBtn().then {
        $0.setTitle("완료했어요", for: .normal)
    }
    
    private var profileList: [MateSearchResModel] = []
    
    var hasBackView: Bool = false
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTapSearchBtn()
        registerTVC()
        setDelegate()
        setTapCompleteBtn()
        setTapBackBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabbar()
    }
}

// MARK: - UI
extension AddFriendVC {
    
    private func configureUI() {
        view.addSubviews([naviBar, searchBarTextField, profileTV, completeBtn])
        profileTV.separatorStyle = .none
        
        /// TableView 하단 space 설정
        profileTV.contentInset.bottom = 10
        
        naviBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        searchBarTextField.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(54)
        }
        
        profileTV.snp.makeConstraints {
            $0.top.equalTo(searchBarTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        completeBtn.snp.makeConstraints {
            $0.top.equalTo(profileTV.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
    }
}

// MARK: - Custom Methods
extension AddFriendVC {
    
    /// 검색하기 버튼 tap Action 설정 메서드
    private func setTapSearchBtn() {
        searchBarTextField.rightBtn.press { [weak self] in
            self?.dismissKeyboard()
            self?.searchMateNickname(nickname: self?.searchBarTextField.text ?? "")
        }
    }
    
    /// 셀 등록 메서드
    private func registerTVC() {
        FriendProfileTVC.register(target: profileTV)
    }
    
    /// 대리자 위임 메서드
    private func setDelegate() {
        searchBarTextField.delegate = self
        profileTV.delegate = self
        profileTV.dataSource = self
    }
    
    /// 완료했어요 버튼 tap Action 설정 메서드
    private func setTapCompleteBtn() {
        completeBtn.press { [weak self] in
            guard let self = self else { return }
            
            if !self.hasBackView {
                let pomeTBC = PomeTBC()
                pomeTBC.modalPresentationStyle = .fullScreen
                self.present(pomeTBC, animated: true, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    /// 뒤로가기 버튼 tap Action 설정 메서드
    private func setTapBackBtn() {
        naviBar.backBtn.press {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - UITextFieldDelegate
extension AddFriendVC: UITextFieldDelegate {
    
    /// done 키 터치 시 키보드 내려가도록
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBarTextField.resignFirstResponder()

        return true
    }
}

// MARK: - ProfileCellDelegate
extension AddFriendVC: ProfileCellDelegate {
    func sendFollowingState(indexPath: IndexPath, followingState: Bool) {
        profileList[indexPath.row].isFriend = followingState
        addMate(targetID: profileList[indexPath.row].id)
    }
}

// MARK: - UITableViewDelegate
extension AddFriendVC: UITableViewDelegate {
    
    /// cell 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.adjustedH
    }
}

// MARK: - UITableViewDataSource
extension AddFriendVC: UITableViewDataSource {
    
    /// cell 개수 지정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileList.count
    }
    
    /// cell 삽입
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendProfileTVC.className) as? FriendProfileTVC else { return UITableViewCell() }
        
        cell.setData(data: profileList[indexPath.row], indexPath: indexPath)
        cell.sendBtnStatusDelegate = self
        
        return cell
    }
}

// MARK: - Network
extension AddFriendVC {
    
    /// 친구 검색 메서드
    private func searchMateNickname(nickname: String) {
        SignAPI.shared.searchMateAPI(nickname: nickname) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? [MateSearchResModel] {
                    DispatchQueue.main.async {
                        self.profileList = data
                        self.profileTV.reloadData()
                    }
                }
            case .requestErr:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
    
    /// 친구 추가 요청 메서드
    private func addMate(targetID: Int) {
        SignAPI.shared.addMateAPI(targetID: targetID) { networkResult in
            switch networkResult {
            case .success(_):
                
                // TODO: 로딩뷰 멈춤
                break
            case .requestErr:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}

