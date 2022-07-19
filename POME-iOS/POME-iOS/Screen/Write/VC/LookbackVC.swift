//
//  LookbackVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/11.
//

import UIKit

class LookbackVC: BaseVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var naviBar: PomeNaviBar!
    @IBOutlet weak var lookbackMainCV: UICollectionView!
    
    // MARK: Properties
    private var spend: [String] = ["spend1", "spend2", "spend3", "spend4"]
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBar()
        setDelegate()
        registerCV()
        setTapBackBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideTabbar()
    }
}

// MARK: - UI
extension LookbackVC {
    
    private func configureNaviBar() {
        naviBar.setNaviStyle(state: .greyBackDefault)
    }
}

// MARK: - Custom Methods
extension LookbackVC {
    
    private func setDelegate() {
        lookbackMainCV.delegate = self
        lookbackMainCV.dataSource = self
    }
    
    private func registerCV() {
        LookbackCVC.register(target: lookbackMainCV)
        SpendCVC.register(target: lookbackMainCV)
    }
    
    private func setTapBackBtn() {
        naviBar.backBtn.press { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension LookbackVC: UICollectionViewDataSource {
    
    /// 섹션 개수 지정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    /// 섹션 당 셀 개수 지정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0) ? 1 : spend.count
    }
    
    /// 섹션 별 셀 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // TODO: - emptyCVC 추가 필요
        guard let lookbackCVC = lookbackMainCV.dequeueReusableCell(withReuseIdentifier: LookbackCVC.className, for: indexPath) as? LookbackCVC,
              let spendCVC = lookbackMainCV.dequeueReusableCell(withReuseIdentifier: SpendCVC.className, for: indexPath) as? SpendCVC else { return UICollectionViewCell() }
        
        if indexPath.section == 0 {
            lookbackCVC.setData(goal: "술은 좀 줄여보자고", num: 10)
            lookbackCVC.goalBgView.makeRounded(cornerRadius: 6.adjusted)
            lookbackCVC.goalBgView.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.1, radius: 15)
            return lookbackCVC
        } else {
            if spend.count > 0 {
                
                // TODO: - 서버에서 받은 이모지 정보가 있을 경우 해당 이모지로 변경, 이 뷰에서 오른쪽 이모지 default는 btnEmojiPlus38
                spendCVC.rightEmojiBtn.imageView?.image = UIImage(named: "btnEmojiPlus38")
                spendCVC.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.12, radius: 4)
                
                /// 씀씀이 셀의 more 버튼을 누를 경우 action sheet를 띄운다.
                spendCVC.tapMoreBtn = {
                    self.makeTwoAlertWithCancel(okTitle: "수정하기", secondOkTitle: "삭제하기", okAction: { _ in
                        
                        // TODO: - 수정 뷰로 화면 전환
                        print("씀씀이 수정합니다.")
                    }, secondOkAction: { _ in
                        let alert = PomeAlertVC()
                        alert.showPomeAlertVC(vc: self, title: "기록을 삭제하시겠어요?", subTitle: "삭제한 내용은 다시 되돌릴 수 없어요", cancelBtnTitle: "아니요", confirmBtnTitle: "삭제할게요")
                        
                        /// 알럿창의 취소버튼(왼쪽 버튼) 누르는 경우 alert dismiss
                        alert.cancelBtn.press { [weak self] in
                            self?.dismiss(animated: true)
                        }
                        
                        /// 알럿창의 확인버튼(오른쪽 버튼) 누르는 경우 삭제 서버 통신
                        alert.confirmBtn.press { [weak self] in
                            
                            // TODO: - 삭제 서버 통신 필요
                            print("씀씀이 삭제합니다.")
                            self?.dismiss(animated: true)
                        }
                    })
                }
                
                spendCVC.tapPlusBtn = {
                    guard let lookbackSelectVC = UIStoryboard.init(name: Identifiers.WriteSelectFeelingSB, bundle: nil).instantiateViewController(withIdentifier: WriteSelectFeelingVC.className) as? WriteSelectFeelingVC else { return }
                    self.navigationController?.pushViewController(lookbackSelectVC, animated: true)
                }
                return spendCVC
            } else {
                
                // TODO: - emptyCVC로 변경 필요
                return spendCVC
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LookbackVC: UICollectionViewDelegateFlowLayout {
    
    /// 섹션 별 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: 375.adjusted, height: 293)
        } else {
            return CGSize(width: 166.adjusted, height: 188)
        }
    }
    
    /// 섹션 인셋 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 14, left: 16, bottom: 0, right: 16)
            }
        }
    }
    
    /// 섹션 별 셀 위아래 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    /// CV, 섹션 별 셀 좌우 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (section == 0) ? 0 : 11
}
