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
    
    /// 액션 시트를 띄우기 위한 클로저 선언
    var tapMoreBtn: (() -> ())?
    
    // MARK: Life Cycle
    override func setViews() {
        configureUI()
        setTapMoreBtn()
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
            $0.leading.equalTo(contentView).inset(16)
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
            $0.trailing.equalTo(contentView).inset(16)
            $0.height.width.equalTo(24)
        }
        
        spentMoneyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(privateImageView.snp.bottom).offset(20)
            $0.leading.equalTo(contentView).inset(16)
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
            $0.centerX.equalTo(progressView.snp.trailing)
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
            $0.leading.trailing.equalTo(ifSuccessLabelContainerView).inset(6)
            $0.top.bottom.equalTo(ifSuccessLabelContainerView).inset(2)
        }
    }
}

// MARK: - Custom Methods
extension GoalCardCVC {
    
    /// more 버튼 tap Action 설정 메서드
    private func setTapMoreBtn() {
        menuBtn.press { [weak self] in
            self?.tapMoreBtn?()
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
        
        /// 초과 여부에 따른 UI 수정
        if goal > 100 {
            
            /// 100이 초과될때 라벨값과 progress trailing값을 맞추기 위해서 100으로 지정
            progress = 100
            [progressView, percentageContainerView, ifSuccessLabelContainerView].forEach {
                view in view.backgroundColor = .red
            }
            percentageContainerView.snp.remakeConstraints {
                $0.trailing.equalTo(progressView.snp.trailing)
                $0.centerY.equalTo(progressView)
            }
            progressPercentageLabel.snp.remakeConstraints {
                $0.centerX.centerY.equalTo(percentageContainerView)
                $0.leading.trailing.equalTo(percentageContainerView).inset(7)
                $0.top.bottom.equalTo(percentageContainerView).inset(3)
            }
            progressPercentageLabel.text = "초과"
            ifSuccessLabel.text = "실패"
        } else {
            progress = goal
            [progressView, percentageContainerView, ifSuccessLabelContainerView].forEach {
                view in view.backgroundColor = .main
            }
            
            /// goal이 없을 경우와 100인 경우의 UI 수정
            switch goal {
            case 0:
                percentageContainerView.snp.remakeConstraints {
                    $0.leading.equalTo(progressView.snp.leading)
                    $0.centerY.equalTo(progressView)
                }
            case 100:
                percentageContainerView.snp.remakeConstraints {
                    $0.trailing.equalTo(progressView.snp.trailing)
                    $0.centerY.equalTo(progressView)
                }
            default:
                percentageContainerView.snp.remakeConstraints {
                    $0.centerX.equalTo(progressView.snp.trailing)
                    $0.centerY.equalTo(progressView)
                }
            }
            ifSuccessLabel.text = "성공"
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
