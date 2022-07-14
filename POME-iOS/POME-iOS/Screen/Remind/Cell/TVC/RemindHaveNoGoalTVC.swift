//
//  HaveNoGoalTVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/14.
//

import UIKit

class RemindHaveNoGoalTVC: CodeBaseTVC {

    // MARK: Properties
    private let containerView = UIView().then {
        $0.backgroundColor = .grey_0
    }
    
    private let blankImageView = UIImageView().then {
        $0.image = UIImage(named: "icNoting24")
    }
    
    private let descriptionLabel = UILabel().then {
        $0.setLabel(text: "아직 돌아본 씀씀이가 없어요", color: .grey_5, size: 14, weight: .semiBold)
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
extension RemindHaveNoGoalTVC {
    
    private func configureUI() {
        contentView.addSubview(containerView)
        self.containerView.addSubviews([blankImageView, descriptionLabel])
        
        containerView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        blankImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(164.adjustedH)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalTo(blankImageView)
            $0.top.equalTo(blankImageView.snp.bottom).offset(12.adjustedH)
        }
    }
}
