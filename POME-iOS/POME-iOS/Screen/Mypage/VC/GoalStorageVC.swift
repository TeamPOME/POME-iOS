//
//  GoalStorageVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/18.
//

import UIKit

class GoalStorageVC: BaseVC {
    
    // MARK: Properties
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
        setTV()
        setDelegate()
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Custom Methods
extension GoalStorageVC {
    
    private func setTV(){
        GoalCardCVC.register(target: goalStorageCV)
        GoalStorageTitleCVC.register(target: goalStorageCV)
    }
    
    private func setDelegate() {
        goalStorageCV.delegate = self
        goalStorageCV.dataSource = self
    }
    
    private func tapGoBack() {
        naviBar.backBtn.addTarget(self, action: #selector(tapToBack), for: .touchUpInside)
    }
}

// MARK: - Custom Methods
extension GoalStorageVC {
    
    @objc func tapToBack() {
        print("Button was tapped.")
        self.dismiss(animated: true)
    }
}

// MARK: - UITableViewDelegate
extension GoalStorageVC: UICollectionViewDelegate {
    
    /// CV, 섹션 별 셀 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let titleCell = goalStorageCV.dequeueReusableCell(withReuseIdentifier: Identifiers.GoalStorageTitleCVC, for: indexPath) as? GoalStorageTitleCVC,
              let goalCardCell = goalStorageCV.dequeueReusableCell(withReuseIdentifier: Identifiers.GoalCardCVC, for: indexPath) as? GoalCardCVC else { return UICollectionViewCell() }
        if indexPath.section == 0 {
            return titleCell
        } else {
            goalCardCell.setData(GoalDataModel.sampleData[indexPath.row])
            goalCardCell.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.1, radius: 6)
            return goalCardCell
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
        } else {
            return GoalDataModel.sampleData.count
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GoalStorageVC: UICollectionViewDelegateFlowLayout {
    
    /// 섹션에 따라 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: 44.adjustedH)
        } else {
            return CGSize(width: collectionView.bounds.width - 32.adjusted, height: 157.adjustedH)
        }
    }
    
    /// 섹션에 인셋 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
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
