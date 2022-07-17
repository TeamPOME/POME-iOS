//
//  MypageVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/06.
//

import UIKit

class MypageVC: BaseVC {

    // MARK: IBOutlet
    @IBOutlet weak var profileImage: PomeMaskedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myPageNaviBar: PomeNaviBar!
    @IBOutlet weak var profileImageView: PomeMaskedImageView!
    @IBOutlet weak var goalStoarageLabel: UILabel!
    @IBOutlet weak var goalStorageBtnView: UIView!
    @IBOutlet weak var marshmellowCV: UICollectionView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDelegate()
        setCVC()
        setViewTapBtn()
        setData(dataModel: MypageDataModel.sampleData[0])
    }
}

// MARK: - UI
extension MypageVC {
    
    private func configureUI() {
        myPageNaviBar.setNaviStyle(state: .greyWithRightBtn)
        myPageNaviBar.rightCustomBtn.setImage(UIImage(named: "icSetting24Mono"), for: .normal)
        marshmellowCV.isScrollEnabled = false
        goalStorageBtnView.makeRounded(cornerRadius: 6)
    }
}

// MARK: - Custom Method
extension MypageVC {
    
    /// 델리게이트 지정
    private func setDelegate() {
        marshmellowCV.delegate = self
        marshmellowCV.dataSource = self
    }
    
    /// 목표보관함 전체 ContainerView의 클릭 이벤트를 가져옵니다.
    private func setViewTapBtn() {
        let settingTap = UITapGestureRecognizer(target: self, action: #selector(tapGoToGoalPage))
        goalStorageBtnView.isUserInteractionEnabled = true
        goalStorageBtnView.addGestureRecognizer(settingTap)
    }
    
    /// 마시멜로 모으기 셀 등록
    private func setCVC() {
        MarshmellowCVC.register(target: marshmellowCV)
    }
    
    /// 사용자 개인정보 데이터 등록
    func setData(dataModel: MypageDataModel) {
        nameLabel.text = dataModel.mypageName
        profileImageView.maskImage = dataModel.mypageImage
        goalStoarageLabel.text = dataModel.content
    }
}

// MARK: - objc
extension MypageVC {
    
    /// 클릭되었을때 Mypage로 이동
    @objc func tapGoToGoalPage() {
      
        // TODO: 목표보관함 CV로 변경하고 연결
    }
}

// MARK: - UICollectionViewDataSource
extension MypageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = marshmellowCV.dequeueReusableCell(withReuseIdentifier: Identifiers.MarshmellowCVC, for: indexPath) as? MarshmellowCVC else { return UICollectionViewCell() }
        cell.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.12, radius: 6)
        cell.makeRounded(cornerRadius: 6)
        cell.setData(dataModel: MarshmellowDataModel.sampleData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MarshmellowDataModel.sampleData.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MypageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 166.adjusted, height: 180.adjustedH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12.adjusted
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 11.adjusted
    }
}
