//
//  GoalStorageTVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/08.
//

import UIKit
import SnapKit
import Then

class GoalCardCVC: CodeBaseCVC {
    
    // MARK: Properties
    private var progress = 1.0
    
    private let ifSuccessLabelContainerView = UIView().then {
        $0.makeRounded(cornerRadius: 8.adjusted)
        $0.backgroundColor = .grey_5
        $0.clipsToBounds = true
    }
    
    private let ifSuccessLabel = UILabel().then {
        $0.setLabel(text: "gggg", color: .white, size: 10, weight: .semiBold)
        $0.textAlignment = .center
    }
    
    private let privateImageView = UIImageView().then {
        $0.image = UIImage(named: "icLockAll")
    }
    
    private let goalTitleLabel = UILabel().then {
        $0.setLabel(text: "건강을위해줄이자", color: .grey_9, size: 20, weight: .bold)
    }
    
    private let spentMoneyTitleLabel = UILabel().then {
        $0.setLabel(text: "남은 예산", color: .grey_6, size: 12, weight: .semiBold)
    }
    
    private var moneyGoalLabel = UILabel().then {
        $0.setLabel(text: "110000", color: .grey_5, size: 14, weight: .semiBold)
    }
    
    private let realSpentMoneyLabel = UILabel().then {
        $0.setLabel(text: "10000", color: .grey_9, size: 18, weight: .bold)
    }
    
    private let menuBtn = UIButton().then {
        $0.setImage(UIImage(named: "icMore24Grey4"), for: .normal)
    }
    
    private let progressView = UIView().then {
        $0.backgroundColor = .main
        $0.makeRounded(cornerRadius: 4.adjusted)
    }
    
    private let progressContainerView =  UIView().then {
        $0.backgroundColor = .grey_2
        $0.makeRounded(cornerRadius: 4.adjusted)
    }
    
    private let progressPercentageLabel = UILabel().then {
        $0.setLabel(text: "", color: .white, size: 12, weight: .bold)
    }
    
    private let percentageContainerView = UIView().then {
        $0.makeRounded(cornerRadius: 10.adjusted)
        $0.clipsToBounds = true
    }
    
    // MARK: Life Cycle
    override func setViews() {
        configureUI()
    }
}

// MARK: - UI
extension GoalCardCVC {
    
    private func configureUI() {
        contentView.addSubviews([goalTitleLabel,  ifSuccessLabelContainerView, menuBtn, spentMoneyTitleLabel, moneyGoalLabel, realSpentMoneyLabel, privateImageView, progressContainerView, ifSuccessLabelContainerView, percentageContainerView])
        ifSuccessLabelContainerView.addSubview(ifSuccessLabel)
        percentageContainerView.addSubview(progressPercentageLabel)
        progressContainerView.addSubview(progressView)
        contentView.backgroundColor = .white
        contentView.makeRounded(cornerRadius: 6.adjusted)
        
        privateImageView.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(24)
            $0.leading.equalTo(contentView).inset(16.adjusted)
            $0.width.height.equalTo(24)
        }
        
        goalTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(privateImageView.snp.trailing).offset(4)
            $0.centerY.equalTo(privateImageView)
        }
        
        ifSuccessLabelContainerView.snp.makeConstraints {
            $0.centerY.equalTo(privateImageView)
            $0.leading.equalTo(goalTitleLabel.snp.trailing).offset(6)
        }
        
        menuBtn.snp.makeConstraints {
            $0.centerY.equalTo(ifSuccessLabelContainerView)
            $0.trailing.equalTo(contentView).offset(-16)
            $0.height.width.equalTo(24)
        }
        
        spentMoneyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(privateImageView.snp.bottom).offset(20)
            $0.leading.equalTo(contentView).inset(16.adjusted)
        }
        
        realSpentMoneyLabel.snp.makeConstraints {
            $0.leading.equalTo(privateImageView.snp.leading)
            $0.top.equalTo(spentMoneyTitleLabel.snp.bottom).offset(2)
        }
        
        moneyGoalLabel.snp.makeConstraints {
            $0.centerY.equalTo(realSpentMoneyLabel)
            $0.leading.equalTo(realSpentMoneyLabel.snp.trailing).offset(4)
        }
        
        progressContainerView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.top.equalTo(realSpentMoneyLabel.snp.bottom).offset(18)
            $0.bottom.equalTo(contentView).inset(27)
            $0.height.equalTo(6)
        }
        
        progressView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(progress / 100)
        }
        
        percentageContainerView.snp.makeConstraints {
            $0.centerX.equalTo(progressView.snp.trailing).inset(16)
            $0.centerY.equalTo(progressView)
        }
        
        progressPercentageLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(percentageContainerView)
            $0.leading.trailing.equalTo(percentageContainerView).inset(5)
            $0.top.bottom.equalTo(percentageContainerView).inset(3)
        }
        
        ifSuccessLabel.snp.makeConstraints {
            $0.centerX.equalTo(ifSuccessLabelContainerView)
            $0.centerY.equalTo(ifSuccessLabelContainerView)
            $0.leading.trailing.equalTo(ifSuccessLabelContainerView).inset(4)
            $0.top.bottom.equalTo(ifSuccessLabelContainerView).inset(2)
        }
    }
    
    /// progress 값 변경이 밖에서 가능하게 해주는 함수
    private func updateProgress(completion: @escaping () -> Void) {
        completion()
    }
    
    /// progressBar 값 UI  수정이 필요할때 호출하는 함수
    private func updateProgressView() {
        updateProgress { [weak self] in
            self?.progressView.snp.remakeConstraints {
                $0.leading.bottom.top.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy((self?.progress ?? 10) / 100)
            }
        }
    }
    
    /// progress 값에 따라 퍼센트Label 과 progress bar UI 변경해주는 함수
    private func setProgress(goal: Double) {
        if goal > 100 {
            progress = 100
            [progressView, percentageContainerView].forEach {
                view in view.backgroundColor = .red
            }
            progressPercentageLabel.text = "초과"
        } else {
            progress = goal
            [progressView, percentageContainerView].forEach {
                view in view.backgroundColor = .main
            }
            progressPercentageLabel.text = String(format: "%.f", progress) + "%"
        }
        updateProgressView()
    }
}

// MARK: - Network
extension GoalCardCVC {
    
    func setData(_ goalData: GoalDataModel) {
        goalTitleLabel.text = goalData.goalTitle
        ifSuccessLabel.text = goalData.ifSuccessOrNotLabelText
        moneyGoalLabel.text = goalData.goalMoneyLabel
        realSpentMoneyLabel.text = goalData.spentMoneyLabel
        setProgress(goal: goalData.successPercentage)
    }
}
