//
//  MateEmojiBottomSheetVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/19.
//

import UIKit

class MateEmojiBottomSheetVC: BaseVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var allMateBtn: UIButton!
    @IBOutlet weak var merongEmojiBtn: UIButton!
    @IBOutlet weak var flexEmojiBtn: UIButton!
    @IBOutlet weak var sadEmojiBtn: UIButton!
    @IBOutlet weak var happyEmojiBtn: UIButton!
    @IBOutlet weak var heartEmojiBtn: UIButton!
    @IBOutlet weak var surprisedEmojiBtn: UIButton!
    @IBOutlet weak var seeMateEmojiCV: UICollectionView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        registerCVC()
    }
}

// MARK: - Custom Method
extension MateEmojiBottomSheetVC {
    
    /// 델리게이트 지정
    private func setDelegate() {
        seeMateEmojiCV.delegate = self
        seeMateEmojiCV.dataSource = self
    }
    
    /// CVC 셀 등록
    private func registerCVC() {
        MateEmojiHeaderCVC.register(target: seeMateEmojiCV)
        MateEmojiCVC.register(target: seeMateEmojiCV)
    }
    
    /// TODO 서버통신
}

// MARK: - UICollectionViewDataSource
extension MateEmojiBottomSheetVC: UICollectionViewDataSource {
    
    /// 섹션 개수 지정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    /// CV, 섹션 별 셀 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let mateEmojiHeaderCVC = seeMateEmojiCV.dequeueReusableCell(withReuseIdentifier: Identifiers.MateEmojiHeaderCVC, for: indexPath) as? MateEmojiHeaderCVC,
              let mateEmojiCVC = seeMateEmojiCV.dequeueReusableCell(withReuseIdentifier: Identifiers.MateEmojiCVC, for: indexPath) as? MateEmojiCVC else { return UICollectionViewCell() }
        switch indexPath.section {
        case 0:
            return mateEmojiHeaderCVC
        default:
            return mateEmojiCVC
        }
    }
    
    /// 섹션 별 셀 개수 지정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : 8
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MateEmojiBottomSheetVC: UICollectionViewDelegateFlowLayout {
    
    /// 섹션에 따라 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: 370.adjusted, height: 38.adjustedH)
        } else {
            return CGSize(width: 105.adjusted, height: 74.adjustedH)
        }
    }
    
    /// 섹션에 인셋 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
    }
    
    /// 셀별 위아래 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 0 : 20.adjustedH
    }
    
    ///  셀별 사이 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 0 : 14.adjusted
    }
}
