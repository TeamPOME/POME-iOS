//
//  marshmellowCVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/16.
//

import UIKit

class MarshmellowCVC: BaseCVC {

    @IBOutlet weak var labelLevelContainerView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelBadgeContainerView: UIView!
    @IBOutlet weak var levelBadgeLabel: UILabel!
    @IBOutlet weak var marshmellowImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

}

// MARK: - UI
extension MarshmellowCVC {
    
    private func configureUI() {
        labelLevelContainerView.makeRounded(cornerRadius: labelLevelContainerView.frame.width / 2)
        labelLevelContainerView.layer.borderWidth = 1
        labelLevelContainerView.layer.borderColor = .init(red: 1.0, green: 144.0 / 255.0, blue: 138.0 / 255.0, alpha: 1.0)
        levelBadgeContainerView.makeRounded(cornerRadius: 12)
    }
}

// MARK: - Custom Method
extension MarshmellowCVC {
    
    func setData(dataModel: MarshmellowDataModel) {
        levelLabel.text = dataModel.levelLabel
        levelBadgeLabel.text = dataModel.levelBadge
        marshmellowImageView.image = UIImage(named: dataModel.marshmellowImageName ?? "userProfileFill32")
    }
}
