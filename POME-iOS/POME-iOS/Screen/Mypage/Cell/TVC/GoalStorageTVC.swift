//
//  GoalStorageTVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/08.
//

import UIKit
import SnapKit
import Then

class GoalStorageTVC: CodeBaseTVC {
    
    private var progress = 1.0
    
    private let ifSuccessLabelContainerView = UIView().then {
        $0.makeRounded(cornerRadius: 8)
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
        $0.setLabel(text: "", color: .black, size: 20, weight: .bold)
    }
    
    private let spentMoneyTitleLabel = UILabel().then {
        $0.setLabel(text: "사용금액", color: .grey_7, size: 12, weight: .semiBold)
    }
    
    private var moneyGoalLabel = UILabel().then {
        $0.setLabel(text: "", color: .grey_5, size: 14, weight: .semiBold)
    }
    
    private let realSpentMoneyLabel = UILabel().then {
        $0.setLabel(text: "", color: .black, size: 18, weight: .bold)
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
        $0.setLabel(text: "", color: .white, size: 12, weight: .semiBold)
    }
    
    private let percentageContainerView = UIView().then {
        $0.makeRounded(cornerRadius: 10)
        $0.clipsToBounds = true
    }
    
    override func setViews() {
        configureUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - UI
extension GoalStorageTVC {
    
    private func configureUI() {
        
        self.contentView.addSubviews([goalTitleLabel,  ifSuccessLabelContainerView, menuBtn, spentMoneyTitleLabel, moneyGoalLabel, realSpentMoneyLabel, privateImageView, progressContainerView, ifSuccessLabelContainerView, percentageContainerView])
        
        ifSuccessLabelContainerView.addSubview(ifSuccessLabel)
        percentageContainerView.addSubview(progressPercentageLabel)
        progressContainerView.addSubview(progressView)
        
        privateImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24.adjustedH)
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
        
        goalTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(privateImageView.snp.trailing).offset(4.adjusted)
            $0.centerY.equalTo(privateImageView)
        }
        
        ifSuccessLabelContainerView.snp.makeConstraints {
            $0.centerY.equalTo(privateImageView)
            $0.width.equalTo(31.adjusted)
            $0.height.equalTo(16.adjustedH)
            $0.leading.equalTo(goalTitleLabel.snp.trailing).offset(6.adjusted)
        }
        
        menuBtn.snp.makeConstraints {
            $0.centerY.equalTo(ifSuccessLabelContainerView)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.height.equalTo(24.adjustedH)
            $0.width.equalTo(24.adjusted)
        }
        
        spentMoneyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(privateImageView.snp.bottom).offset(18.adjustedH)
            $0.leading.equalTo(privateImageView)
        }
        
        realSpentMoneyLabel.snp.makeConstraints {
            $0.leading.equalTo(privateImageView)
            $0.top.equalTo(spentMoneyTitleLabel.snp.bottom).offset(4.adjustedH)
        }
        
        moneyGoalLabel.snp.makeConstraints {
            $0.centerY.equalTo(realSpentMoneyLabel)
            $0.leading.equalTo(realSpentMoneyLabel.snp.trailing).offset(8.adjusted)
        }
        
        progressContainerView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.leading.equalTo(privateImageView)
            $0.top.equalTo(moneyGoalLabel.snp.bottom).offset(18.adjustedH)
            $0.bottom.equalToSuperview().inset(25.adjustedH)
            $0.height.equalTo(6.adjustedH)
        }
        
        progressView.snp.makeConstraints {
            $0.left.bottom.top.trailing.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(progress / 100)
        }
        
        percentageContainerView.snp.makeConstraints {
            $0.centerX.equalTo(progressView.snp.trailing).inset(16.adjusted)
            $0.width.equalTo(36.adjusted)
            $0.height.equalTo(20.adjustedH)
            $0.centerY.equalTo(progressView)
        }
        
        progressPercentageLabel.snp.makeConstraints {
            $0.centerY.equalTo(percentageContainerView)
            $0.centerX.equalTo(percentageContainerView)
        }
        
        ifSuccessLabel.snp.makeConstraints {
            $0.centerX.equalTo(ifSuccessLabelContainerView)
            $0.centerY.equalTo(ifSuccessLabelContainerView)
        }
    }
    
    private func updateProgress(completion: @escaping () -> Void) {
        completion()
    }
    
    /// 처음에 viewDidLoad의 값이 아닌 변경된 값을 보여줌
    private func updateProgressView() {
        updateProgress { [weak self] in
            self?.progressView.snp.remakeConstraints {
                $0.left.bottom.top.trailing.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy((self?.progress ?? 10) / 100)
            }
        }
    }
    
    /// progressbar의 값이 들어오면 초과, 퍼센트 판별
    private func setProgress(goal: Double) {
        
        if goal > 100 {
            progress = 100
            progressView.backgroundColor = .red
            percentageContainerView.backgroundColor = .red
            progressPercentageLabel.text = "초과"
        }
        else {
            progress = goal
            progressView.backgroundColor = .main
            percentageContainerView.backgroundColor = .main
            progressPercentageLabel.text = String(format: "%.f", progress) + "%"
        }
        
       /// 데이터에 따라 progressView를 다시
        updateProgressView()
    }
}

// MARK: - Network
extension GoalStorageTVC {
    
    ///setData에서 값주기
    func setData(_ goalData: GoalDataModel) {
        goalTitleLabel.text = goalData.goalTitle
        ifSuccessLabel.text = goalData.ifSuccessOrNotLabelText
        moneyGoalLabel.text = goalData.goalMoneyLabel
        realSpentMoneyLabel.text = goalData.spentMoneyLabel
        setProgress(goal: goalData.successPercentage)
    }
}
