//
//  WriteBottomAlertVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/15.
//

import UIKit

class WriteBottomAlertVC: BaseVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    var reselectFirstItem: (() -> ())?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: IBAction
    @IBAction func tapCloseBtn(_ sender: UIButton) {
        reselectFirstItem?()
        self.dismiss(animated: true)
    }
}

// MARK: - Custom Methods
extension WriteBottomAlertVC {
    
    private func configureUI() {
        topConstraint.constant = screenHeight == 667 ? 12 : 24.adjustedH
        imageHeight.constant = 110.adjustedH
        subLabel.setLineSpacing(lineSpacing: 4)
        subLabel.textAlignment = .center
    }
    
    func configureContent(type: String) {
        switch type {
        case "spend":
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(named: "writingWarningAlert3DComponent")
                self.titleLabel.text = "지금은 씀씀이를 기록할 수 없어요"
                self.subLabel.text = "나만의 소비 목표를 설정하고\n기록을 시작해보세요!"
            }
        case "feeling":
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(named: "3DPenPink110")
                self.titleLabel.text = "아직은 감정을 기록할 수 없어요"
                self.subLabel.text = "일주일이 지나야 감정을 남길 수 있어요\n나중에 다시 봐요!"
            }
        default:
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(named: "3D10WarningSheet")
                self.titleLabel.text = "목표는 10개까지만 만들 수 있어요"
                self.subLabel.text = "포미는 사용자가 무리하지 않고 즐겁게 목표를\n달성할 수 있도록 응원하고 있어요"
                
                /// "5개" 글자만 색상을 변경한다.
                guard let titleText = self.titleLabel.text else { return }
                let attributeString = NSMutableAttributedString(string: titleText)
                attributeString.addAttribute(.foregroundColor, value: UIColor.sub, range: (titleText as NSString).range(of: "10개"))
                self.titleLabel.attributedText = attributeString
            }
        }
    }
}
