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
    private let naviBar = PomeNaviBar().then {
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
    
    private var profileList: [FriendListData] = []
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTapSearchBtn()
        registerTVC()
        setDelegate()
        initProfileList()
        setTapCompleteBtn()
    }
}

// MARK: - UI
extension AddFriendVC {
    
    private func configureUI() {
        view.addSubviews([naviBar, searchBarTextField, profileTV, completeBtn])
        profileTV.isHidden = true
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
            self?.profileTV.isHidden = false
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
    
    /// 데이터 삽입 메서드
    private func initProfileList() {
        profileList.append(contentsOf: [
            FriendListData(nickname: "은주", profileImageName: "sampleProfile", isFollowing: false),
            FriendListData(nickname: "주현", profileImageName: "sampleProfile", isFollowing: false),
            FriendListData(nickname: "유진", profileImageName: "sampleProfile", isFollowing: false),
            FriendListData(nickname: "지영", profileImageName: "sampleProfile", isFollowing: false),
            FriendListData(nickname: "희빈", profileImageName: "sampleProfile", isFollowing: false),
            FriendListData(nickname: "세훈", profileImageName: "sampleProfile", isFollowing: false),
            FriendListData(nickname: "효진", profileImageName: "sampleProfile", isFollowing: false),
            FriendListData(nickname: "연진", profileImageName: "sampleProfile", isFollowing: false),
            FriendListData(nickname: "포미포미", profileImageName: "sampleProfile", isFollowing: false),
            FriendListData(nickname: "포미", profileImageName: "sampleProfile", isFollowing: false),
            FriendListData(nickname: "POME", profileImageName: "sampleProfile", isFollowing: false),
            FriendListData(nickname: "하이", profileImageName: "sampleProfile", isFollowing: false)
        ])
    }
    
    /// 완료했어요 버튼 tap Action 설정 메서드
    private func setTapCompleteBtn() {
        completeBtn.press { [weak self] in
            guard let self = self else { return }
            
            let pomeTBC = PomeTBC()
            pomeTBC.modalPresentationStyle = .fullScreen
            self.present(pomeTBC, animated: true, completion: nil)
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
        profileList[indexPath.row].isFollowing = followingState
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

