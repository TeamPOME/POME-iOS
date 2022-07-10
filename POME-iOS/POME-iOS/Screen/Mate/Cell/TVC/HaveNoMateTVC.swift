//
//  haveNoMateTVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/10.
//

import UIKit

class HaveNoMateTVC: CodeBaseTVC {

    // MARK: Properties
    private let allContainerView = UIView().then {
        $0.backgroundColor = .grey_0
    }
    
    private let blankImageView = UIImageView().then {
        $0.image = UIImage(named: "icNoting24")
    }
    
    private let descriptionLabel = UILabel().then {
        $0.setLabel(text: "아직 추가한 친구가 없어요", color: .grey_5, size: 14, weight: .semiBold)
    }
    
    override func setViews() {
        configureUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - UI
extension HaveNoMateTVC {
    
    private func configureUI() {
        contentView.addSubview(allContainerView)
        self.allContainerView.addSubviews([blankImageView, descriptionLabel])
        
        allContainerView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        blankImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(183.adjustedH)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalTo(blankImageView)
            $0.top.equalTo(blankImageView.snp.bottom).offset(12.adjustedH)
        }
    }
}
