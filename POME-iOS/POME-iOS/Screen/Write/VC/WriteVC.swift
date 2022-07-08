//
//  WriteVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/06.
//

import UIKit

class WriteVC: BaseVC {

    // MARK: IBOutlet
    @IBOutlet weak var writeHomeNaviBar: PomeNaviBar!
    @IBOutlet weak var goalCV: UICollectionView!
    @IBOutlet weak var writeMainCV: UICollectionView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMainCV()
        configureUI()
    }
}

// MARK: - UI
extension WriteVC {
    private func configureUI() {
        writeHomeNaviBar.setNaviStyle(state: .greyWithRightBtn)
    }
}

// MARK: - UICollectionViewDelegate
extension WriteVC: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
}

// MARK: - UICollectionViewDataSource
extension WriteVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let goalCardCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: GoalCardCVC.className, for: indexPath) as? GoalCardCVC else { return UICollectionViewCell() }
        goalCardCVC.makeRounded(cornerRadius: 10)
        guard let feelingCardCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: FeelingCardCVC.className, for: indexPath) as? FeelingCardCVC else {
                    return UICollectionViewCell() }
        guard let spendCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: SpendCVC.className, for: indexPath) as? SpendCVC else { return UICollectionViewCell() }
        spendCVC.makeRounded(cornerRadius: 10)
        
        switch indexPath.section {
        case 0:
            return goalCardCVC
        case 1:
            return feelingCardCVC
        default:
            return spendCVC
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WriteVC: UICollectionViewDelegateFlowLayout {
    
    /// 섹션에 따라 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: 343.adjusted, height: 157)
        case 1:
            return CGSize(width: 343.adjusted, height: 118)
        default:
            return CGSize(width: 166, height: 188)
        }
    }
    
    /// 섹션에 인셋 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        case 1:
            return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        default:
            return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        }
    }
    
    /// 셀 간 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0, 1:
            return 0
        default:
            return 12
        }
    }
    
    /// 셀 간 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0, 1:
            return 0
        default:
            return 11
        }
    }
}

// MARK: - Custom Methods
extension WriteVC {
    private func setMainCV() {
        writeMainCV.delegate = self
        writeMainCV.dataSource = self
        FeelingCardCVC.register(target: writeMainCV)
        GoalCardCVC.register(target: writeMainCV)
        SpendCVC.register(target: writeMainCV)
    }
}
