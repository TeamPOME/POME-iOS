//
//  RemindVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/06.
//

import UIKit

class RemindVC: BaseVC {
    
    // MARK: Properties
    private var selectedCategoryIndex = 0
    private var selectedPreviousEmoji: Bool = false
    private var selectedLatestEmoji: Bool = false
    private var selectedResetBtn: Bool = false
    private var getPreviousEmoji: String = ""
    private var getLatestEmoji: String = ""
    private var category: [RemindGoalModel] = []
    private var selectedCategory: RemindGoalModel = RemindGoalModel(id: 0, category: "", message: "", isPublic: true)
    private var goalRecordList: [RemindGoalListModel] = []
    
    private lazy var goalCategoryCV = UICollectionView( frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .grey_0
    }
    
    private let remindTV = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .grey_0
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.sectionHeaderHeight = 0
        $0.sectionFooterHeight = 0
    }
    
    private let remindHomeNaviBar = PomeNaviBar().then {
        $0.setNaviStyle(state: .greyWithRightBtn)
        $0.configureRightCustomBtn(imgName: "icAlarmAll")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        registerCell()
        setDelegate()
    }
    
    /// 탭바가 왔다갔다 할 경우 첫 셀이 default가 되게끔 처리하였다.
    override func viewWillAppear(_ animated: Bool) {
        requestGetRemind()
        setTVScroll()
    }
}

// MARK: - UI
extension RemindVC {
    
    private func configureUI() {
        view.backgroundColor = .grey_0
        remindTV.backgroundColor = .grey_0
        goalCategoryCV.backgroundColor = .grey_0
        remindTV.separatorStyle = .none
        remindTV.showsVerticalScrollIndicator = false
        remindTV.sectionHeaderHeight = 0
        remindTV.sectionFooterHeight = 0
        view.addSubviews([goalCategoryCV,remindTV,remindHomeNaviBar])
        
        remindHomeNaviBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        goalCategoryCV.snp.makeConstraints {
            $0.top.equalTo(remindHomeNaviBar.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(41)
        }
        
        remindTV.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(goalCategoryCV.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Custom Methods
extension RemindVC {
    
    private func setDelegate() {
        goalCategoryCV.delegate = self
        goalCategoryCV.dataSource = self
        remindTV.delegate = self
        remindTV.dataSource = self
    }
    
    /// 셀 등록
    private func registerCell() {
        RemindGoalTitleTVC.register(target: remindTV)
        RemindHaveNoGoalTVC.register(target: remindTV)
        RemindGoalTVC.register(target: remindTV)
        RemindFilterTVC.register(target: remindTV)
        RemindGoalCategoryCVC.register(target: goalCategoryCV)
    }
    
    /// 목표가 없을때는 스크롤이 안되도록 막아두었다.
    private func setTVScroll() {
        remindTV.isScrollEnabled = (goalRecordList.count == 0) ? false : true
    }
    
    /// 목표 카테고리의 다른탭으로 눌리기 전의 탭으로 눌리게끔 default 설정
    private func setDefaultSelectedCell(index: Int) {
        self.goalCategoryCV.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .right)
        if !category.isEmpty {
            self.selectedCategory = category[index]
        }
    }
}

// MARK: - @objc
extension RemindVC {
    
    /// 필터 기능 Bottom Sheet
    @objc func showFilterHalfModalVC(index: Int) {
        let halfModalVC = RemindSelectFeelingVC()
        halfModalVC.modalPresentationStyle = .custom
        halfModalVC.transitioningDelegate = self
        
        /// 바텀시트 선택값이 넘어오는 델리게이트를 채택함
        halfModalVC.selectFeelingDelegate = self
        halfModalVC.isFirstEmotion = (index == 0)
        self.present(halfModalVC, animated: true, completion: nil)
    }
    
    /// 친구 반응 Bottom Sheet
    @objc func showMateEmojiHalfModalVC() {
        let halfModalVC = MateEmojiBottomSheetVC()
        halfModalVC.modalPresentationStyle = .custom
        halfModalVC.transitioningDelegate = self
        self.present(halfModalVC, animated: true, completion: nil)
    }
}

// MARK: - SelectFeelingDelegate
extension RemindVC: SelectFeelingDelegate {
    
    /// 바텀시트에서 이모지가 클릭되었을때, tableview를 reload 시켜주는 경우
    func selectPreviousEmoji(previousEmoji: String) {
        if previousEmoji != "" {
            getPreviousEmoji = previousEmoji
            selectedPreviousEmoji = true
            selectedResetBtn = false
            remindTV.reloadData()
        }
    }
    
    func selectLatestEmoji(latestEmoji: String) {
        if latestEmoji != "" {
            getLatestEmoji = latestEmoji
            selectedLatestEmoji = true
            selectedResetBtn = false
            remindTV.reloadData()
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension RemindVC: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let halfModalVC = PomeHalfModalVC(presentedViewController: presented, presenting: presenting)
        
        /// 필터기능의 BottomSheet
        if presented.className == RemindSelectFeelingVC().className {
            
            /// HalfModalView의 높이 지정
            halfModalVC.modalHeight = 235
        }
        
        /// 친구반응을 볼때 띄우는 Bottom Sheet
        else {
            halfModalVC.modalHeight = 342
        }
        return halfModalVC
    }
}

// MARK: - UITableViewDelegate
extension RemindVC: UITableViewDelegate {
    
    /// 셀별 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 99
        case 1:
            return 84
        default:
            return (category.count == 0) ? 430.adjustedH : 157
        }
    }
    
    /// 셀 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let remindGoalTitleTVC = remindTV.dequeueReusableCell(withIdentifier: Identifiers.RemindGoalTitleTVC) as? RemindGoalTitleTVC,
              let remindFilterTVC = remindTV.dequeueReusableCell(withIdentifier: Identifiers.RemindFilterTVC) as? RemindFilterTVC,
              let remindNoGoalTVC = remindTV.dequeueReusableCell(withIdentifier: Identifiers.RemindHaveNoGoalTVC) as? RemindHaveNoGoalTVC,
              let remindGoalTVC = remindTV.dequeueReusableCell(withIdentifier: Identifiers.RemindGoalTVC) as? RemindGoalTVC else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            if category.count == 0 {
                remindGoalTitleTVC.isPrivateImageView.image = UIImage(named: "icEmptyGoal")
                remindGoalTitleTVC.goalTitleLabel.setLabel(text: "아직 추가한 목표가 없어요", color: .grey_5, size: 18, weight: .bold)
            } else {
                remindGoalTitleTVC.goalTitleLabel.setLabel(text: selectedCategory.message, color: .grey_8, size: 18, weight: .bold)
                if selectedCategory.isPublic {
                    remindGoalTitleTVC.isPrivateImageView.image = UIImage(named: "icNoLockAll")
                } else {
                    remindGoalTitleTVC.isPrivateImageView.image = UIImage(named: "icLockAll")
                }
            }
            return remindGoalTitleTVC
        case 1:
            
            /// bottomsheet를 띄어야할때 클로저를 사용한 코드이다 ( 첫 감정 = 0 , 후 감정 = 1)
            /// 바텀시트를 선택하지 않고 띄우기만 한 경우는 selected를 false로 처리해주었다.
            remindFilterTVC.selectFilterAction = { num in
                if num == 0 {
                    self.showFilterHalfModalVC(index: 0)
                    self.selectedPreviousEmoji = false
                } else {
                    self.showFilterHalfModalVC(index: 1)
                    self.selectedLatestEmoji = false
                }
            }
            
            /// 초기화버튼 처리 해주는 클로저
            remindFilterTVC.selectResetBtnAction = { check in
                if check == true {
                    self.getPreviousEmoji = ""
                    self.getLatestEmoji = ""
                    self.selectedResetBtn = check
                    self.selectedPreviousEmoji = false
                    self.selectedLatestEmoji = false
                }
            }
            
            /// 바텀시트에 값 입력이 안되었을 경우이거나  바텀시트의 이모지를 선택하지 않고 껐을 경우 분기처리
            if (getPreviousEmoji != "" || selectedPreviousEmoji == true) && selectedResetBtn == false {
                remindFilterTVC.previousFeelingBtn.setTitleColor(.sub, for: .normal)
                remindFilterTVC.previousFeelingBtn.backgroundColor = .pomeMiddlePink
                remindFilterTVC.previousFeelingBtn.setTitle(getPreviousEmoji, for: .normal)
                remindFilterTVC.previousFeelingBtn.setImage(UIImage(named: "icArrowDown17Pink"), for: .normal)
            }
            
            if (getLatestEmoji != "" || selectedLatestEmoji == true) && selectedResetBtn == false {
                remindFilterTVC.laterFeelingBtn.setTitleColor(.sub, for: .normal)
                remindFilterTVC.laterFeelingBtn.backgroundColor = .pomeMiddlePink
                remindFilterTVC.laterFeelingBtn.setTitle(getLatestEmoji, for: .normal)
                remindFilterTVC.laterFeelingBtn.tintColor = .sub
                remindFilterTVC.laterFeelingBtn.setImage(UIImage(named: "icArrowDown17Pink"), for: .normal)
            }
            
            /// 초기화버튼이 눌렸을때의 UI처리
            if selectedResetBtn == true {
                [remindFilterTVC.previousFeelingBtn, remindFilterTVC.laterFeelingBtn].forEach {
                    $0?.backgroundColor = .grey_2
                    $0?.setTitleColor(.grey_5, for: .normal)
                    $0?.tintColor = .grey_5
                    $0?.makeRounded(cornerRadius: 4.adjusted)
                    $0?.setImage(UIImage(named: "icArrowDown17"), for: .normal)
                    $0?.semanticContentAttribute = .forceRightToLeft
                }
                remindFilterTVC.previousFeelingBtn.setTitle("처음 감정", for: .normal)
                remindFilterTVC.laterFeelingBtn.setTitle("돌아본 감정", for: .normal)
            }
            remindFilterTVC.selectionStyle = .none
            return remindFilterTVC
        case 2:
            if category.count == 0 || goalRecordList.isEmpty{
                return remindNoGoalTVC
            } else {
                remindGoalTVC.setData(remindGoalData: goalRecordList[indexPath.row])
                remindGoalTVC.tapMateEmojiBtnAction = {
                    self.showMateEmojiHalfModalVC()
                }
                return remindGoalTVC
            }
        default:
            return UITableViewCell()
        }
    }
    
    /// 각 섹션 안의 셀 개수 지정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return (category.count == 0 || goalRecordList.count == 0) ? 1 : goalRecordList.count
        }
    }
}

// MARK: - UITableViewDataSource
extension RemindVC: UITableViewDataSource {
    
    /// 섹션 개수 설정
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}

// MARK: - UICollectionViewDataSource
extension RemindVC: UICollectionViewDataSource {
    
    /// 섹션 개수 지정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    /// 섹션 별 셀 개수 지정 - 목표가 있을때와 없을 때 구분
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count == 0 ? 1 : category.count
    }
    
    /// CV, 섹션 별 셀 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let remindGoalCategoryCVC = goalCategoryCV.dequeueReusableCell(withReuseIdentifier: Identifiers.RemindGoalCategoryCVC, for: indexPath) as? RemindGoalCategoryCVC else { return UICollectionViewCell() }
        if category.count == 0 {
            remindGoalCategoryCVC.goalLabel.text = " - "
        } else {
            remindGoalCategoryCVC.goalLabel.text = category[indexPath.row].category
        }
        return remindGoalCategoryCVC
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RemindVC: UICollectionViewDelegateFlowLayout {
    
    /// 섹션에 따라 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if category.count == 0 {
            return CGSize(width: " - ".size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 32, height: 29)
        } else {
            
            /// 글씨 길이에 따라 너비 동적 조절
            return CGSize(width: category[indexPath.row].category.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 33, height: 29)
        }
    }
    
    /// 섹션에 인셋 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 7, left: 16, bottom: 6, right: 16)
    }
    
    /// 섹션 별 셀 위아래 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /// CV, 섹션 별 셀 좌우 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !category.isEmpty {
            selectedCategoryIndex = indexPath.row
            selectedCategory = category[selectedCategoryIndex]
            reqeustGetRemindGoal(goalId: category[indexPath.row].id)
            remindTV.reloadData()
        }
    }
}

// MARK: - Network
extension RemindVC {
    
    /// 상단의 카테고리 목록 요청
    private func requestGetRemind() {
        RemindAPI.shared.requestGetRemindGoalAPI() {
            networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? [RemindGoalModel] {
                    DispatchQueue.main.async {
                        self.category = data
                        self.remindTV.reloadData()
                        self.goalCategoryCV.reloadData()
                        self.setDefaultSelectedCell(index: self.selectedCategoryIndex)
                    }
                }
            case .requestErr:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
    
    /// 상단의 카테고리에 따른 목표 리스트 요청
    private func reqeustGetRemindGoal(goalId: Int) {
        RemindAPI.shared.requestGetRemindGoalListAPI(goalId: goalId) {
            networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? [RemindGoalListModel] {
                    DispatchQueue.main.async {
                        self.goalRecordList = data
                        self.remindTV.reloadData()
                        self.setTVScroll()
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
