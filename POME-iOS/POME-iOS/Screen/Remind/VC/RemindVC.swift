//
//  RemindVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/06.
//

import UIKit

class RemindVC: BaseVC {
    
    // MARK: Properties
    private var goalCount: Int = 10
    private var category: [String] = ["목표를 정해요", "목표 선택", "목표 설정", "목표 진행", "목표 완료", "목표를 정해요", "목표 선택", "목표 설정", "목표 진행", "목표 완료"]
    private var categoryIsSelectedArray = [Bool](repeating: false, count: 10)
    
    private lazy var goalCategoryCV = UICollectionView( frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .grey_0
    }
    
    private let remindTV = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .grey_0
        $0.showsVerticalScrollIndicator = false
        $0.sectionHeaderTopPadding = 1
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
        setTVScroll()
    }
    
    /// 첫 아이템이 처음 로딩 되었을때만 설정. 그 뒤의 선택에 영향가지 않게 하였다
    override func viewWillAppear(_ animated: Bool) {
        setDefaultSelectedCell()
    }
}

// MARK: - UI
extension RemindVC {
    
    private func configureUI() {
        view.backgroundColor = .grey_0
        remindTV.backgroundColor = .grey_0
        goalCategoryCV.backgroundColor = .grey_0
        remindTV.separatorStyle = .none
        remindTV.separatorColor = .grey_0
        view.addSubviews([goalCategoryCV,remindTV,remindHomeNaviBar])
        
        remindHomeNaviBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44.adjustedH)
        }
        
        goalCategoryCV.snp.makeConstraints {
            $0.top.equalTo(remindHomeNaviBar.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10.adjusted)
            $0.height.equalTo(41.adjustedH)
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
        remindTV.isScrollEnabled = (goalCount == 0) ? false : true
    }
    
    /// 목표 카테고리의 첫 아이템을 디폴트로 설정
    private func setDefaultSelectedCell() {
        self.goalCategoryCV.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
    }
}

// MARK: - UITableViewDelegate
extension RemindVC: UITableViewDelegate {
    
    /// 셀별 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 96.adjustedH
        case 1:
            return 84.adjustedH
        default:
            return (goalCount == 0) ? 430.adjustedH : 157.adjustedH
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
            if goalCount == 0 {
                remindGoalTitleTVC.isPrivateImageView.image = UIImage(named: "icEmptyGoal")
                remindGoalTitleTVC.goalTitleLabel.setLabel(text: "아직 추가한 목표가 없어요", color: .grey_5, size: 18, weight: .bold)
            }
            return remindGoalTitleTVC
        case 1:
            return remindFilterTVC
        case 2:
            if goalCount == 0 {
                return remindNoGoalTVC
            } else {
                remindGoalTVC.setData(RemindGoalDataModel.sampleData[indexPath.row])
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
            return goalCount == 0 ? 1 : RemindGoalDataModel.sampleData.count
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
        return goalCount == 0 ? 1 : category.count
    }
    
    // CV, 섹션 별 셀 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let remindGoalCategoryCVC = goalCategoryCV.dequeueReusableCell(withReuseIdentifier: Identifiers.RemindGoalCategoryCVC, for: indexPath) as? RemindGoalCategoryCVC else { return UICollectionViewCell() }
        if goalCount == 0 {
            remindGoalCategoryCVC.goalLabel.text = " - "
        } else{
            remindGoalCategoryCVC.goalLabel.text = category[indexPath.row]
        }
        return remindGoalCategoryCVC
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RemindVC: UICollectionViewDelegateFlowLayout {
    
    /// 섹션에 따라 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if goalCount == 0 {
            return CGSize(width: " - ".size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 32, height: 29)
        } else{
            /// 글씨 길이에 따라 너비 동적 조절
            return CGSize(width: category[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 32, height: 29)
        }
    }
    
    /// 섹션에 인셋 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
    }
    
    /// 섹션 별 셀 위아래 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /// CV, 섹션 별 셀 좌우 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.adjusted
    }
}

