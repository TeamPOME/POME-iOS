//
//  WriteSelectFeelingVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/11.
//

import UIKit

class WriteSelectFeelingVC: BaseVC {
    
    // MARK: Properties
    var isRecord: Bool = false
    
    // MARK: IBOutlet
    @IBOutlet weak var naviBar: PomeNaviBar!
    @IBOutlet weak var closeBtn: UIButton!
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
    @IBAction func tapCloseBtn(_ sender: UIButton) {
        let alert = PomeAlertVC()
        alert.showPomeAlertVC(vc: self, title: "작성을 그만 두시겠어요?", subTitle: "지금까지 작성한 내용은 모두 사라져요", cancelBtnTitle: "이어서 쓸래요", confirmBtnTitle: "그만둘래요", iconImage: UIImage(named: "3DPenMint100"))
        
        /// 알럿창의 이어서 쓸래요(왼쪽 버튼) 누르는 경우 alert dismiss
        alert.cancelBtn.press { [weak self] in
            self?.dismiss(animated: true)
        }
        
        /// 알럿창의 그만둘래요(오른쪽 버튼) 누르는 경우 알럿창 없앤 후 기록탭 메인으로 돌아감
        alert.confirmBtn.press { [weak self] in
            self?.dismiss(animated: false) {
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
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
        let nextVC: UIViewController
        
        if isRecord {
            guard let addRecordCompleteVC = UIStoryboard.init(name: Identifiers.AddCompleteSB, bundle: nil).instantiateViewController(withIdentifier: AddCompleteVC.className) as? AddCompleteVC else { return }
            addRecordCompleteVC.isRecord = self.isRecord
            nextVC = addRecordCompleteVC
        } else {
            guard let lookbackCompleteVC = UIStoryboard.init(name: Identifiers.LookbackCompleteSB, bundle: nil).instantiateViewController(withIdentifier: LookbackCompleteVC.className) as? LookbackCompleteVC else { return }
            nextVC = lookbackCompleteVC
        }

        navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - UI
extension WriteSelectFeelingVC {
    
    private func configureUI() {
        naviBar.setNaviStyle(state: .whiteBackDefault)
        saveEmojiBtn.setTitle("남겼어요", for: .normal)
        saveEmojiBtn.isDisabled = true
        if isRecord {
            closeBtn.isHidden = false
            titleLabel.text = "소비한 순간의\n솔직한 감정을 남겨주세요"
            subLabel.text = "포미는 순간의 감정에 집중해\n한번 기록된 감정은 바꿀 수 없어요"
            configureHappyUI()
            configureDontKnowUI()
            configureRegretUI()
        }
        [titleLabel, subLabel].forEach {
            $0?.setLineSpacing(lineSpacing: 4)
            $0?.textAlignment = .left
        }
    }
    
    /// 행복해요 버튼 선택에 따른 이미지와 레이블 색 설정 메서드
    private func configureHappyUI() {
        if isRecord {
            happyBtn.setImgByName(name: "btnEmojiHappyMint110Nor", selectedName: "btnEmojiHappyMint110Sel")
            happyLabel.textColor = happyBtn.isSelected ? .main : .grey_7
        } else {
            happyBtn.setImgByName(name: "btnEmojiHappyPink110Nor", selectedName: "btnEmojiHappyPink110Sel")
            happyLabel.textColor = happyBtn.isSelected ? .sub : .grey_7
        }
    }
    
    /// 모르겠어요 버튼 선택에 따른 이미지와 레이블 색 설정 메서드
    private func configureDontKnowUI() {
        if isRecord {
            dontKnowBtn.setImgByName(name: "btnEmojiWhatMint110Nor", selectedName: "btnEmojiWhatMint110Sel")
            dontKnowLabel.textColor = dontKnowBtn.isSelected ? .main : .grey_7
        } else {
            dontKnowBtn.setImgByName(name: "btnEmojiWhatPink110Nor", selectedName: "btnEmojiWhatPink110Sel")
            dontKnowLabel.textColor = dontKnowBtn.isSelected ? .sub : .grey_7
        }
    }
    
    /// 후회해요 버튼 선택에 따른 이미지와 레이블 색 설정 메서드
    private func configureRegretUI() {
        if isRecord {
            regretBtn.setImgByName(name: "btnEmojiSadMint110Nor", selectedName: "btnEmojiSadMint110Sel")
            regretLabel.textColor = regretBtn.isSelected ? .main : .grey_7
        } else {
            regretBtn.setImgByName(name: "btnEmojiSadPink110Nor", selectedName: "btnEmojiSadPink110Sel")
            regretLabel.textColor = regretBtn.isSelected ? .sub : .grey_7
        }
    }
}

// MARK: - Custom Methods
extension WriteSelectFeelingVC {
    
    private func setTapBackBtn() {
        naviBar.backBtn.press { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
