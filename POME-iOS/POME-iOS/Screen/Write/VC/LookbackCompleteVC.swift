//
//  LookbackCompleteVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/11.
//

import UIKit

class LookbackCompleteVC: BaseVC {
    
    // MARK: Properties
    var amount: Int = 0
    var startEmotion: Int = 0
    var endEmotion: Int = 0

    // MARK: IBOutlet
    @IBOutlet weak var completeBtn: PomeBtn!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var firstEmojiImageView: UIImageView!
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var firstSubLabel: UILabel!
    @IBOutlet weak var secondEmojiImageView: UIImageView!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var secondSubLabel: UILabel!
    @IBOutlet weak var contentTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setData()
        setNaviBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setNaviBar()
    }
    
    // MARK: IBAction
    @IBAction func tapCompleteBtn(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UI
extension LookbackCompleteVC {
    
    private func configureUI() {
        completeBtn.setTitle("확인했어요", for: .normal)
        explainLabel.setLineSpacing(lineSpacing: 4)
        explainLabel.textAlignment = .center
        subTitleLabel.setLineSpacing(lineSpacing: 4)
        subTitleLabel.textAlignment = .left
        if screenHeight == 667 {
            contentTopConstraint.constant = 40
            bottomConstraint.constant = 34
        }
    }
}

// MARK: - Custom Methods
extension LookbackCompleteVC {
    
    /// 오른쪽으로 swipe시 뒤로가기 활성화 여부
    private func setNaviBar() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled.toggle()
    }
    
    private func setData() {
        priceLabel.text = "\(numberFormatter(number: amount))원을 사용했어요"
        
        switch startEmotion {
        case 1:
            firstEmojiImageView.image = UIImage(named: "icHeartCircle52")
            firstTitleLabel.text = "씀씀이 당시 행복했어요"
            firstSubLabel.text = "나를 위한 만족스러운 씀씀이를 하셨군요!"
        case 2:
            firstEmojiImageView.image = UIImage(named: "icWhatCircle52")
            firstTitleLabel.text = "씀씀이 당시 아리송했어요"
            firstSubLabel.text = "괜찮아요. 앞으로 조금씩 감정에 집중해봐요!"
        default:
            firstEmojiImageView.image = UIImage(named: "icSadCircle52")
            firstTitleLabel.text = "씀씀이 당시 후회했어요"
            firstSubLabel.text = "괜찮아요. 다음 번엔 조금 더 고민해봐요!"
        }
        
        switch endEmotion {
        case 1:
            secondEmojiImageView.image = UIImage(named: "icHeartCirclePink52")
            secondTitleLabel.text = "일주일 뒤 행복했어요"
            secondSubLabel.text = "일주일 뒤에 만족스러운 씀씀이, 축하해요!"
        case 2:
            secondEmojiImageView.image = UIImage(named: "icWhatCirclePink52")
            secondTitleLabel.text = "일주일 뒤 아리송했어요"
            secondSubLabel.text = "괜찮아요. 기록하며 나를 위한 소비를 찾아요!"
        default:
            secondEmojiImageView.image = UIImage(named: "icSadCirclePink52")
            secondTitleLabel.text = "일주일 뒤 후회했어요"
            secondSubLabel.text = "괜찮아요. 다음 씀씀이는 만족스러울거에요!"
        }
    }
}
