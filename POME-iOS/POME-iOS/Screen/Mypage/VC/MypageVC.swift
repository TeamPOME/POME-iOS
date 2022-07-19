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
    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var profileImageView: PomeMaskedImageView!
    @IBOutlet weak var goalStorageLabel: UILabel!
    @IBOutlet weak var goalStorageBtnView: UIView!
    @IBOutlet weak var marshmellowCV: UICollectionView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDelegate()
        setViewTapAction()
        registerCVC()
        setData(dataModel: MypageDataModel.sampleData[0])
    }
}

// MARK: - UI
extension MypageVC {
    
    private func configureUI() {
        myPageNaviBar.setNaviStyle(state: .greyWithRightBtn)
        myPageNaviBar.rightCustomBtn.setImage(UIImage(named: "icSetting24Mono"), for: .normal)
        marshmellowCV.isScrollEnabled = false
        checkView.makeRounded(cornerRadius: checkView.frame.width / 2)
        goalStorageBtnView.makeRounded(cornerRadius: 6.adjusted)
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
    private func setViewTapAction() {
        let settingTap = UITapGestureRecognizer(target: self, action: #selector(presentGoalStorage))
        goalStorageBtnView.isUserInteractionEnabled = true
        goalStorageBtnView.addGestureRecognizer(settingTap)
    }
    
    /// 마시멜로 모으기 셀 등록
    private func registerCVC() {
        MarshmellowCVC.register(target: marshmellowCV)
    }
    
    /// 사용자 개인정보 데이터 등록
    func setData(dataModel: MypageDataModel) {
        nameLabel.text = dataModel.mypageName
        profileImageView.maskImage = dataModel.mypageImage
        goalStorageLabel.text = dataModel.content
    }
}

// MARK: - @objc
extension MypageVC {
    
    /// 클릭되었을때 Mypage로 이동
    @objc func presentGoalStorage() {
        let goalStorage = GoalStorageVC()
        self.navigationController?.pushViewController(goalStorage, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MypageVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = marshmellowCV.dequeueReusableCell(withReuseIdentifier: Identifiers.MarshmellowCVC, for: indexPath) as? MarshmellowCVC else { return UICollectionViewCell() }
        cell.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.12, radius: 6)
        cell.makeRounded(cornerRadius: 6.adjusted)
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
        return CGSize(width: 166, height: 180)
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
