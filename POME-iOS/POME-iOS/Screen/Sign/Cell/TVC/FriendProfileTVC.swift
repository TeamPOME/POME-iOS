//
//  FriendProfileTVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/14.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class FriendProfileTVC: CodeBaseTVC {

    // MARK: Properties
    private let profileImageView = PomeMaskedImageView().then {
        $0.image = UIImage(named: "sampleProfile")
        $0.maskImage = UIImage(named: "userProfileEmpty160")
        $0.contentMode = .scaleAspectFill
    }
    
    private let nicknameLabel = UILabel().then {
        $0.textColor = .grey_9
        $0.font = .PretendardM(size: 16)
        $0.textAlignment = .left
    }
    
    private let plusBtn = UIButton().then {
        $0.setImage(UIImage(named: "icPlus20"), for: .normal)
    }
    
    private lazy var completeLabel = UILabel().then {
        $0.text = "추가 완료"
        $0.textColor = .grey_5
        $0.textAlignment = .center
        $0.font = .PretendardSB(size: 12)
        $0.backgroundColor = .grey_1
        $0.makeRounded(cornerRadius: 6.adjusted)
    }
    
    weak var sendBtnStatusDelegate: ProfileCellDelegate?
    private var followingState: Bool = false
    private var indexPath: IndexPath?
    
    // MARK: Life Cycle
    override func setViews() {
        configureUI()
        setTapPlusBtn()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// TableViewCell 재사용 문제 해결을 위한 초기화
    override func prepareForReuse() {
        super.prepareForReuse()
        followingState = false
    }
}

// MARK: - UI
extension FriendProfileTVC {
    
    private func configureUI() {
        contentView.addSubviews([profileImageView, nicknameLabel, plusBtn, completeLabel])
        completeLabel.isHidden = true
        
        profileImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(13)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(profileImageView.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
            $0.centerY.equalTo(profileImageView)
        }
        
        plusBtn.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(13)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(plusBtn.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        completeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(32)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(55)
            $0.height.equalTo(22)
        }
    }
}

// MARK: - Custom Methods
extension FriendProfileTVC {
    
    /// 데이터 세팅 함수
    func setData(data: MateSearchResModel, indexPath: IndexPath) {
        let url = URL(string: data.profileImage)
        
        profileImageView.kf.setImage(with: url)
        nicknameLabel.text = data.nickname
        
        followingState = data.isFriend
        plusBtn.isHidden = data.isFriend
        completeLabel.isHidden = !data.isFriend
        
        self.indexPath = indexPath
    }
    
    /// +버튼 tap Action 설정 메서드
    func setTapPlusBtn() {
        plusBtn.press { [weak self] in
            guard let self = self else { return }
            
            self.plusBtn.isHidden = true
            self.completeLabel.isHidden = false
            self.sendBtnStatusDelegate?.sendFollowingState(indexPath: self.indexPath ?? IndexPath(item: 0, section: 0), followingState: true)
        }
    }
}

