//
//  MypageVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/06.
//

import UIKit
import Kingfisher

class MypageVC: BaseVC {

    // MARK: Properties
    private var UserData: UserResModel = UserResModel(nickname: "", profileImage: "", marshmallows: Marshmallows(recordLevel: 0, reactLevel: 0, growLevel: 0, frankLevel: 0) , goalStorageCount: 0)
    private var marshmallow: Marshmallows = Marshmallows(recordLevel: 0, reactLevel: 0, growLevel: 0, frankLevel: 0)
    
    // MARK: IBOutlet
    @IBOutlet weak var profileImage: PomeMaskedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myPageNaviBar: PomeNaviBar!
    @IBOutlet weak var checkView: UIView!
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestUser()
    }
}

// MARK: - UI
extension MypageVC {
    
    private func configureUI() {
        myPageNaviBar.setNaviStyle(state: .greyWithRightBtn)
        profileImage.maskImage = UIImage(named: "userProfileEmpty160")
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
    func setData(data: UserResModel) {
        let url = URL(string: data.profileImage)

        profileImage.kf.setImage(with: url)
        nameLabel.text = data.nickname.description
        goalStorageLabel.text = "다시 보고 싶은 지난 목표가 \(data.goalStorageCount.description)건 있어요"
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
        if UserData.goalStorageCount == 0 {
            [cell.labelLevelContainerView, cell.levelBadgeContainerView, cell.levelLabel, cell.levelBadgeLabel].forEach {
                $0?.isHidden = true
            }
            cell.marshmellowImageView.image = UIImage(named: "marshmallowUnlock")
        } else {
            if indexPath.row == 0 {
                [cell.labelLevelContainerView, cell.levelBadgeContainerView, cell.levelLabel, cell.levelBadgeLabel].forEach {
                    $0?.isHidden = false
                }
                cell.levelLabel.text = "Lv.\(marshmallow.recordLevel.description)"
                cell.levelBadgeLabel.text = "기록말랑"
                if marshmallow.recordLevel == 0 {
                    cell.marshmellowImageView.image = UIImage(named: "marshmallowUnlock")
                } else if marshmallow.recordLevel < 4 {
                    cell.marshmellowImageView.image = UIImage(named: "marshmallowLevel\(marshmallow.recordLevel)Pink")
                } else {
                    cell.marshmellowImageView.image = UIImage(named: "marshmallowLevel4Pink")
                }
            } else if indexPath.row == 1 {
                [cell.labelLevelContainerView, cell.levelBadgeContainerView, cell.levelLabel, cell.levelBadgeLabel].forEach {
                    $0?.isHidden = false
                }
                cell.levelLabel.text = "Lv.\(marshmallow.reactLevel.description)"
                cell.levelBadgeLabel.text = "공감말랑"
                if marshmallow.reactLevel == 0 {
                    cell.marshmellowImageView.image = UIImage(named: "marshmallowUnlock")
                } else if marshmallow.reactLevel < 4 {
                    cell.marshmellowImageView.image = UIImage(named: "marshmallowLevel\(marshmallow.reactLevel)Blue")
                } else {
                    cell.marshmellowImageView.image = UIImage(named: "marshmallowLevel4Blue")
                }
            } else if indexPath.row == 2 {
                [cell.labelLevelContainerView, cell.levelBadgeContainerView, cell.levelLabel, cell.levelBadgeLabel].forEach {
                    $0?.isHidden = false
                }
                cell.levelLabel.text = "Lv.\(marshmallow.growLevel.description)"
                cell.levelBadgeLabel.text = "발전말랑"
                if marshmallow.growLevel == 0 {
                    cell.marshmellowImageView.image = UIImage(named: "marshmallowUnlock")
                } else if marshmallow.growLevel < 4 {
                    cell.marshmellowImageView.image = UIImage(named: "marshmallowLevel\(marshmallow.growLevel)Yellow")
                } else {
                    cell.marshmellowImageView.image = UIImage(named: "marshmallowLevel4Yellow")
                }
            } else {
                [cell.labelLevelContainerView, cell.levelBadgeContainerView, cell.levelLabel, cell.levelBadgeLabel].forEach {
                    $0?.isHidden = false
                }
                cell.levelLabel.text = "Lv.\(marshmallow.frankLevel.description)"
                cell.levelBadgeLabel.text = "솔직말랑"
                if marshmallow.frankLevel == 0 {
                    cell.marshmellowImageView.image = UIImage(named: "marshmallowUnlock")
                } else if marshmallow.frankLevel < 4 {
                    cell.marshmellowImageView.image = UIImage(named: "marshmallowLevel\(marshmallow.frankLevel)Mint")
                } else {
                    cell.marshmellowImageView.image = UIImage(named: "marshmallowLevel4Mint")
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MypageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 166.adjusted, height: 180.adjustedH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
}

// MARK: - Network
extension MypageVC {
    
    /// 마이페이지 유저 정보
    private func requestUser() {
        MypageAPI.shared.requestUserAPI {
            networkResult in
            switch networkResult {
            case .success(let data):
                guard let data = data as? UserResModel else { return }
                DispatchQueue.main.async {
                    self.UserData = data
                    self.marshmallow = self.UserData.marshmallows
                    self.setData(data: self.UserData)
                    self.marshmellowCV.reloadData()
                }
            case .requestErr:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}

