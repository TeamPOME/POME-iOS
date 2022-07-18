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
        setTapBackAction()
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
              let goalCardCell = goalStorageCV.dequeueReusableCell(withReuseIdentifier: Identifiers.GoalCardCVC, for: indexPath) as? GoalCardCVC else { return UICollectionViewCell() }
        if indexPath.section == 0 {
            return titleCell
        } else {
            goalCardCell.setData(GoalDataModel.sampleData[indexPath.row])
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
                        
                        // TODO: - 삭제 서버 통신 필요
                        self?.dismiss(animated: true)
                    }
                })
            }
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
        return (section == 0) ? 1 : GoalDataModel.sampleData.count
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
