//
//  LookbackSelectVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/11.
//

import UIKit

class LookbackSelectVC: BaseVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var naviBar: PomeNaviBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var saveEmojiBtn: PomeBtn!
    @IBOutlet weak var happyBtn: UIButton!
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var dontKnowBtn: UIButton!
    @IBOutlet weak var dontKnowLabel: UILabel!
    @IBOutlet weak var regretBtn: UIButton!
    @IBOutlet weak var regretLabel: UILabel!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTapBackBtn()
    }
    
    // MARK: IBAction
    @IBAction func tapEmojiBtn(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        /// 선택된 버튼 제외한 버튼 select 상태를 false로 바꿈
        [happyBtn, dontKnowBtn, regretBtn].forEach { btn in
            if sender != btn {
                btn?.isSelected = false
            }
        }
        
        configureHappyUI()
        configureDontKnowUI()
        configureRegretUI()
        
        saveEmojiBtn.isDisabled = !(happyBtn.isSelected || dontKnowBtn.isSelected || regretBtn.isSelected)
    }
    
    @IBAction func tapConfirmBtn(_ sender: UIButton) {
        guard let lookbackCompleteVC = UIStoryboard.init(name: Identifiers.LookbackCompleteSB, bundle: nil).instantiateViewController(withIdentifier: LookbackCompleteVC.className) as? LookbackCompleteVC else { return }
        navigationController?.pushViewController(lookbackCompleteVC, animated: true)
    }
}

// MARK: - UI
extension LookbackSelectVC {
    
    private func configureUI() {
        naviBar.setNaviStyle(state: .whiteBackDefault)
        saveEmojiBtn.setTitle("남겼어요", for: .normal)
        saveEmojiBtn.isDisabled = true
        titleLabel.setLineSpacing(lineSpacing: 4)
        titleLabel.textAlignment = .left
        subLabel.setLineSpacing(lineSpacing: 4)
        subLabel.textAlignment = .left
    }
    
    /// 행복해요 버튼 선택에 따른 이미지와 레이블 색 설정 메서드
    private func configureHappyUI() {
        happyBtn.setImgByName(name: "btnEmojiHappyPink110Nor", selectedName: "btnEmojiHappyPink110Sel")
        happyLabel.textColor = happyBtn.isSelected ? .sub : .grey_7
    }
    
    /// 모르겠어요 버튼 선택에 따른 이미지와 레이블 색 설정 메서드
    private func configureDontKnowUI() {
        dontKnowBtn.setImgByName(name: "btnEmojiWhatPink110Nor", selectedName: "btnEmojiWhatPink110Sel")
        dontKnowLabel.textColor = dontKnowBtn.isSelected ? .sub : .grey_7
    }
    
    /// 후회해요 버튼 선택에 따른 이미지와 레이블 색 설정 메서드
    private func configureRegretUI() {
        regretBtn.setImgByName(name: "btnEmojiSadPink110Nor", selectedName: "btnEmojiSadPink110Sel")
        regretLabel.textColor = regretBtn.isSelected ? .sub : .grey_7
    }
}

// MARK: - Custom Methods
extension LookbackSelectVC {
    
    private func setTapBackBtn() {
        naviBar.backBtn.press { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
