//
//  MypageVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/06.
//

import UIKit

class MypageVC: BaseVC {

    // MARK: Properties
    @IBOutlet weak var profileImage: PomeMaskedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myPageNaviBar: PomeNaviBar!
    @IBOutlet weak var profileImageView: PomeMaskedImageView!
    @IBOutlet weak var goalStorageBtnView: UIView!
    @IBOutlet weak var marshmellowCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDelegate()
        setCVC()
    }
}

// MARK: - UI
extension MypageVC {
    
    private func configureUI() {
        myPageNaviBar.setNaviStyle(state: .greyWithRightBtn)
        myPageNaviBar.rightCustomBtn.setImage(UIImage(named: "icSetting24Mono"), for: .normal)
        marshmellowCV.isScrollEnabled = false
    }
}

// MARK: - Custom Method
extension MypageVC {
    
    private func setDelegate() {
        marshmellowCV.delegate = self
        marshmellowCV.dataSource = self
    }
    
    private func setViewTapBtn() {
        let settingTap = UITapGestureRecognizer(target: self, action: #selector(settingTapped))
        goalStorageBtnView.isUserInteractionEnabled = true
        goalStorageBtnView.addGestureRecognizer(settingTap)
    }
    
    private func setCVC() {
        MarshmellowCVC.register(target: marshmellowCV)
    }
}

// MARK: - objc
extension MypageVC {
    
    @objc func settingTapped() {
      print("클릭입니다.")
    }
}

extension MypageVC: UICollectionViewDelegate {
    
}

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
