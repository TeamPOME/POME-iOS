//
//  FriendProfileTVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/14.
//

import UIKit
import SnapKit
import Then

class FriendProfileTVC: CodeBaseTVC {

    // MARK: Properties
    private let profileImageView = PomeMaskedImageView().then {
        $0.image = UIImage(named: "sampleProfile")
        $0.maskImage = UIImage(named: "userProfileEmpty160")
    }
    
    private let nicknameLabel = UILabel().then {
        $0.textColor = .grey_9
        $0.font = .PretendardM(size: 16)
        $0.textAlignment = .left
    }
    
    private let plusBtn = UIButton().then {
        $0.setImage(UIImage(named: "icPlus20"), for: .normal)
    }
    
    // MARK: Life Cycle
    override func setViews() {
        configureUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - UI
extension FriendProfileTVC {
    
    private func configureUI() {
        contentView.addSubviews([profileImageView, nicknameLabel, plusBtn])
        
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
    }
}

// MARK: - Custom Methods
extension FriendProfileTVC {
    
    /// 데이터 세팅 함수
    func setData(data: FriendListData) {
        profileImageView.image = data.makeProfileImage()
        nicknameLabel.text = data.nickname
    }
}

