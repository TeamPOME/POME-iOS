//
//  LookbackVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/11.
//

import UIKit

class LookbackVC: BaseVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var naviBar: PomeNaviBar!
    @IBOutlet weak var lookbackMainCV: UICollectionView!
    
    // MARK: Properties
    private var spend: [String] = ["spend1", "spend2", "spend3", "spend4"]
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBar()
        setDelegate()
        registerCV()
    }
}

// MARK: - UI
extension LookbackVC {
    
    private func configureNaviBar() {
        naviBar.setNaviStyle(state: .greyBackDefault)
    }
}

// MARK: - Custom Methods
extension LookbackVC {
    
    private func setDelegate() {
        lookbackMainCV.delegate = self
        lookbackMainCV.dataSource = self
    }
    
    private func registerCV() {
        LookbackCVC.register(target: lookbackMainCV)
        SpendCVC.register(target: lookbackMainCV)
    }
}

// MARK: - UICollectionViewDataSource
extension LookbackVC: UICollectionViewDataSource {
    
    /// 섹션 개수 지정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    /// 섹션 당 셀 개수 지정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0) ? 1 : spend.count
    }
    
    /// 섹션 별 셀 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // TODO: - emptyCVC 추가 필요
        guard let lookbackCVC = lookbackMainCV.dequeueReusableCell(withReuseIdentifier: LookbackCVC.className, for: indexPath) as? LookbackCVC,
              let spendCVC = lookbackMainCV.dequeueReusableCell(withReuseIdentifier: SpendCVC.className, for: indexPath) as? SpendCVC else { return UICollectionViewCell() }
        
        if indexPath.section == 0 {
            lookbackCVC.setData(goal: "술은 좀 줄여보자고", num: 10)
            lookbackCVC.goalBgView.makeRounded(cornerRadius: 6.adjusted)
            lookbackCVC.goalBgView.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.1, radius: 15)
            return lookbackCVC
        } else {
            if spend.count > 0 {
                
                // TODO: - 서버에서 받은 이모지 정보가 있을 경우 해당 이모지로 변경, 이 뷰에서 오른쪽 이모지 default는 btnEmojiPlus38
                spendCVC.rightEmojiImageView.image = UIImage(named: "btnEmojiPlus38")
                spendCVC.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.12, radius: 4)
                return spendCVC
            } else {
                
                // TODO: - emptyCVC로 변경 필요
                return spendCVC
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LookbackVC: UICollectionViewDelegateFlowLayout {
    
    /// 섹션 별 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: 375.adjusted, height: 293)
        } else {
            return CGSize(width: 166.adjusted, height: 188)
        }
    }
    
    /// 섹션 인셋 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 14, left: 16, bottom: 0, right: 16)
            }
        }
    }
    
    /// 섹션 별 셀 위아래 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    /// CV, 섹션 별 셀 좌우 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (section == 0) ? 0 : 11
}
