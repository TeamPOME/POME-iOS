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
        guard let feelingCardCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: FeelingCardCVC.className, for: indexPath) as? FeelingCardCVC else {
                    return UICollectionViewCell() }
        guard let spendCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: SpendCVC.className, for: indexPath) as? SpendCVC else { return UICollectionViewCell() }
        
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
