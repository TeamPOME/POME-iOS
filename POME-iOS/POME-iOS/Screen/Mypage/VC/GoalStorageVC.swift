//
//  GoalStorageVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/18.
//

import UIKit

class GoalStorageVC: BaseVC {
    
    // MARK: Properties
    private var goalStorageDataList: [GoalStorageResModel] = []
    
    private lazy var goalStorageCV = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .grey_0
    }
    
    private let naviBar = PomeNaviBar().then {
        $0.setNaviStyle(state: .greyBackDefault)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        registerTV()
        setDelegate()
        setTapBackAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestGoalStorageAPI()
    }
}

// MARK: - UI
extension GoalStorageVC {
    
    private func configureView() {
        view.backgroundColor = .grey_0
        view.addSubviews([goalStorageCV,naviBar])
    }
    
    private func configureUI() {
        configureView()
        
        naviBar.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        goalStorageCV.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(naviBar.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(14)
        }
    }
}

// MARK: - Custom Methods
extension GoalStorageVC {
    
    private func registerTV(){
        GoalCardCVC.register(target: goalStorageCV)
        GoalStorageTitleCVC.register(target: goalStorageCV)
        HaveNoGoalInStorageCVC.register(target: goalStorageCV)
    }
    
    private func setDelegate() {
        goalStorageCV.delegate = self
        goalStorageCV.dataSource = self
    }
    
    private func setTapBackAction() {
        naviBar.backBtn.press { [weak self] in
            self?.navigationController?.popViewController(animated: true) }
    }
}

// MARK: - UITableViewDelegate
extension GoalStorageVC: UICollectionViewDelegate {
    
    /// CV, 섹션 별 셀 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let titleCell = goalStorageCV.dequeueReusableCell(withReuseIdentifier: Identifiers.GoalStorageTitleCVC, for: indexPath) as? GoalStorageTitleCVC,
              let goalCardCell = goalStorageCV.dequeueReusableCell(withReuseIdentifier: Identifiers.GoalCardCVC, for: indexPath) as? GoalCardCVC,
              let noGoalCardCell = goalStorageCV.dequeueReusableCell(withReuseIdentifier: Identifiers.HaveNoGoalInStorageCVC, for: indexPath) as? HaveNoGoalInStorageCVC
        else { return UICollectionViewCell() }
        if indexPath.section == 0 {
            return titleCell
        } else {
            if goalStorageDataList.isEmpty {
                return noGoalCardCell
            } else{
                goalCardCell.setData(goalStorageDataList[indexPath.row])
                goalCardCell.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.1, radius: 6)
                
                /// 목표 카드의 more 버튼을 누를 경우 취소 버튼 띄우기
                goalCardCell.tapMoreBtn = {
                    self.makeOneAlertWithCancel(okTitle: "삭제하기", okAction: { _ in
                        let alert = PomeAlertVC()
                        alert.showPomeAlertVC(vc: self, title: "목표를 삭제하시겠어요?", subTitle: "해당 목표에서 작성한 기록도 모두 삭제돼요", cancelBtnTitle: "아니요", confirmBtnTitle: "삭제할게요")
                        
                        /// 알럿창의 취소버튼(왼쪽 버튼) 누르는 경우 alert dismiss
                        alert.cancelBtn.press { [weak self] in
                            self?.dismiss(animated: true)
                        }
                        
                        /// 알럿창의 확인버튼(오른쪽 버튼) 누르는 경우 삭제 서버 통신
                        alert.confirmBtn.press { [weak self] in
                            if let id = self?.goalStorageDataList[indexPath.row].id {
                                self?.requestDeleteGoalAPI(goalId: id)
                            }
                            self?.dismiss(animated: true)
                        }
                    })
                }
                return goalCardCell
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension GoalStorageVC: UICollectionViewDataSource {
    
    /// 섹션 개수 지정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    /// 섹션 별 셀 개수 지정 - 목표가 있을때와 없을 때 구분
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if goalStorageDataList.isEmpty {
            return 1
        } else {
            return goalStorageDataList.count
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GoalStorageVC: UICollectionViewDelegateFlowLayout {
    
    /// 섹션에 따라 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: 44)
        } else if goalStorageDataList.isEmpty {
            return CGSize(width: collectionView.bounds.width, height: 698.adjustedH)
        } else {
            return CGSize(width: collectionView.bounds.width - 32, height: 157)
        }
    }
    
    /// 섹션에 인셋 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 || goalStorageDataList.isEmpty {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        }
    }
    
    /// 섹션 별 셀 위아래 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14.adjustedH
    }
    
    /// CV, 섹션 별 셀 좌우 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.adjusted
    }
}

// MARK: - Network
extension GoalStorageVC {
    
    /// 목표보관함 요청
    private func requestGoalStorageAPI() {
        MypageAPI.shared.requestGoalStorageAPI() { networkResult in
            switch networkResult {
            case .success(let data):
                guard let data = data as? [GoalStorageResModel] else { return }
                DispatchQueue.main.async {
                    self.goalStorageDataList = data
                    self.goalStorageCV.reloadData()
                }
            case .requestErr:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
    
    /// 목표보관함 삭제
    private func requestDeleteGoalAPI(goalId: Int) {
        MypageAPI.shared.requestDeleteGoalAPI(goalId: goalId) { networkResult in
            switch networkResult {
            case .success(_):
                self.requestGoalStorageAPI()
            case .requestErr:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}

