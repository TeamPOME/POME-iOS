//
//  PomeAlertVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/11.
//

import UIKit
import SnapKit
import Then

class PomeAlertVC: BaseVC {
    
    // MARK: Properties
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 8.adjusted)
    }
    
    private let iconImageView = UIImageView().then {
        $0.image = UIImage(named: "3DTrashCanMint100")
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .grey_9
        $0.font = .PretendardSB(size: 14)
        $0.sizeToFit()
    }
    
    private let subTitleLabel = UILabel().then {
        $0.textColor = .grey_6
        $0.font = .PretendardM(size: 12)
    }
    
    let cancelBtn = PomeBtn().then {
        $0.setTitleWithStyle(title: "", size: 16, weight: .semiBold)
        $0.setBtnColors(normalBgColor: .grey_1, normalFontColor: .grey_5, disabledBgColor: .grey_1, disabledFontColor: .grey_5)
        $0.isDisabled = false
    }
    
    let confirmBtn = PomeBtn().then {
        $0.setTitleWithStyle(title: "", size: 16, weight: .semiBold)
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - UI
extension PomeAlertVC {
    
    private func configureUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        view.addSubview(containerView)
        containerView.addSubviews([iconImageView, titleLabel, subTitleLabel, cancelBtn, confirmBtn])
        
        containerView.snp.makeConstraints {
            $0.width.equalTo(288)
            $0.height.equalTo(250)
            $0.centerX.centerY.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        cancelBtn.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(containerView.snp.leading).inset(20)
            $0.width.equalTo(118)
            $0.height.equalTo(39)
        }
        
        confirmBtn.snp.makeConstraints {
            $0.top.equalTo(cancelBtn.snp.top)
            $0.leading.equalTo(cancelBtn.snp.trailing).offset(12)
            $0.width.equalTo(118)
            $0.height.equalTo(39)
        }
    }
}

// MARK: - Public Methods
extension PomeAlertVC {
    
    /// 알럿 보여주는 메서드
    func showPomeAlertVC(vc: UIViewController, title: String, subTitle: String, cancelBtnTitle: String, confirmBtnTitle: String, iconImage: UIImage? = UIImage(named: "3DTrashCanMint100")) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
        cancelBtn.setTitle(cancelBtnTitle, for: .normal)
        confirmBtn.setTitle(confirmBtnTitle, for: .normal)
        iconImageView.image = iconImage
        
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        vc.present(self, animated: true, completion: nil)
    }
}
