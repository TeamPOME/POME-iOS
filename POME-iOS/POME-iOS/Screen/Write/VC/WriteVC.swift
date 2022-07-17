//
//  WriteVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/06.
//

import UIKit

class WriteVC: BaseVC {
    
    // MARK: IBOutlet
    @IBOutlet weak var writeHomeNaviBar: PomeNaviBar!
    @IBOutlet weak var goalCategoryCV: UICollectionView!
    @IBOutlet weak var writeMainCV: UICollectionView!
    
    // MARK: Properties
    private var category: [String] = ["category1", "category2", "category3", "category4", "category5", "category6", "category7", "category8", "category9"]
//    private var category = Array<String>()
    private var spend: [String] = ["spend1", "spend2", "spend3", "spend4"]
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        registerCV()
        configureNaviBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showTabbar()
        setGoalCategoryCV()
    }
}

// MARK: - UI
extension WriteVC {
    
    private func configureNaviBar() {
        writeHomeNaviBar.setNaviStyle(state: .greyWithRightBtn)
    }
    
    /// 목표 카테고리의 첫 아이템을 디폴트로 설정
    private func setGoalCategoryCV() {
        if category.count > 0 {
            goalCategoryCV.selectItem(at: IndexPath(item: 1, section: 0), animated: false, scrollPosition: .right)
        }
    }
}

// MARK: - Custom Methods
extension WriteVC {
    
    private func setDelegate() {
        writeMainCV.delegate = self
        writeMainCV.dataSource = self
        goalCategoryCV.delegate = self
        goalCategoryCV.dataSource = self
    }
    
    private func registerCV() {
        FeelingCardCVC.register(target: writeMainCV)
        EmptyGoalCardCVC.register(target: writeMainCV)
        SpendCVC.register(target: writeMainCV)
        GoalCardCVC.register(target: writeMainCV)
        GoalCategoryCVC.register(target: goalCategoryCV)
        PlusCVC.register(target: goalCategoryCV)
    }
}

// MARK: - @objc
extension WriteVC {
    
    /// 만들어 둔 HalfModalVC 보여주는 함수
    @objc func showHalfModalVC(content: String) {
        let halfModalVC = WriteBottomAlertVC()
        halfModalVC.modalPresentationStyle = .custom
        halfModalVC.transitioningDelegate = self
        halfModalVC.configureContent(type: content)
        
        /// dismiss 될 경우 다시 첫번 째 목표를 선택한다.
        halfModalVC.reselectFirstItem = {
            DispatchQueue.main.async {
                self.setGoalCategoryCV()
            }
        }
        self.present(halfModalVC, animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension WriteVC: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let halfModalVC = PomeHalfModalVC(presentedViewController: presented, presenting: presenting)
        
        /// dismiss 될 경우 다시 첫번 째 목표를 선택한다.
        halfModalVC.reselectFirstItem = {
            DispatchQueue.main.async {
                self.setGoalCategoryCV()
            }
        }
        
        /// HalfModalView의 높이 지정
        halfModalVC.modalHeight = 266
        return halfModalVC
    }
}

// MARK: - UICollectionViewDelegate
extension WriteVC: UICollectionViewDelegate {
    
    /// 셀이 선택되었을 때의 처리
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == goalCategoryCV {
            
            /// 플러스 버튼 눌렀을 때
            if indexPath.row == 0 {
                if category.count >= 10 {
                    showHalfModalVC(content: "goal")
                } else {
                    guard let addGoalDateVC = UIStoryboard.init(name: Identifiers.AddGoalDateSB, bundle: nil).instantiateViewController(withIdentifier: AddGoalDateVC.className) as? AddGoalDateVC else { return }
                    navigationController?.pushViewController(addGoalDateVC, animated: true)
                }
            } else {
                
                // TODO: - 서버 통신 (setData 필요)
            }
        } else {
            
            /// 목표카드가 하나도 없을 때 목표카드부분 (section 0)을 누르면 목표 추가 뷰로 이동
            if indexPath.section == 0 && category.count == 0 {
                guard let addGoalDateVC = UIStoryboard.init(name: Identifiers.AddGoalDateSB, bundle: nil).instantiateViewController(withIdentifier: AddGoalDateVC.className) as? AddGoalDateVC else { return }
                navigationController?.pushViewController(addGoalDateVC, animated: true)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WriteVC: UICollectionViewDataSource {
    
    /// 섹션 개수 지정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (collectionView == goalCategoryCV) ? 1 : 3
    }
    
    /// 섹션 별 셀 개수 지정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == goalCategoryCV {
            return category.count + 1
        } else {
            return (section == 2) ? spend.count : 1
        }
    }
    
    // CV, 섹션 별 셀 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let EmptyGoalCardCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: EmptyGoalCardCVC.className, for: indexPath) as? EmptyGoalCardCVC,
              let GoalCardCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: GoalCardCVC.className, for: indexPath) as? GoalCardCVC,
              let feelingCardCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: FeelingCardCVC.className, for: indexPath) as? FeelingCardCVC,
              let spendCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: SpendCVC.className, for: indexPath) as? SpendCVC,
              let goalCategoryCVC = goalCategoryCV.dequeueReusableCell(withReuseIdentifier: GoalCategoryCVC.className, for: indexPath) as? GoalCategoryCVC,
              let plusCVC = goalCategoryCV.dequeueReusableCell(withReuseIdentifier: PlusCVC.className, for: indexPath) as? PlusCVC else { return UICollectionViewCell() }
        
        if collectionView == goalCategoryCV {
            if indexPath.row == 0 {
                return plusCVC
            } else {
                goalCategoryCVC.goalLabel.text = category[indexPath.row - 1]
                return goalCategoryCVC
            }
        } else {
            switch indexPath.section {
            case 0:
                if category.count == 0 {
                    EmptyGoalCardCVC.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.1, radius: 15)
                    return EmptyGoalCardCVC
                } else {
                    GoalCardCVC.setData(GoalDataModel.sampleData[indexPath.row])
                    GoalCardCVC.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.1, radius: 15)
                    
                    /// 목표 카드의 more 버튼을 누를 경우 action sheet를 띄운다.
                    GoalCardCVC.tapMoreBtn = {
                        self.makeOneAlertWithCancel(okTitle: "삭제하기", okAction: { _ in
                            let alert = PomeAlertVC()
                            alert.showPomeAlertVC(vc: self, title: "목표를 삭제하시겠어요?", subTitle: "해당 목표에서 작성한 기록도 모두 삭제돼요", cancelBtnTitle: "아니요", confirmBtnTitle: "삭제할게요")
                            
                            /// 알럿창의 취소버튼(왼쪽 버튼) 누르는 경우 alert dismiss
                            alert.cancelBtn.press { [weak self] in
                                self?.dismiss(animated: true)
                            }
                            
                            /// 알럿창의 확인버튼(오른쪽 버튼) 누르는 경우 삭제 서버 통신
                            alert.confirmBtn.press { [weak self] in
                                
                                // TODO: - 삭제 서버 통신 필요
                                print("목표카드 삭제합니다.")
                                self?.dismiss(animated: true)
                            }
                        })
                    }
                    return GoalCardCVC
                }
            case 1:
                feelingCardCVC.tapLookbackView = {
                    guard let lookbackVC = UIStoryboard.init(name: Identifiers.LookbackSB, bundle: nil).instantiateViewController(withIdentifier: LookbackVC.className) as? LookbackVC else { return }
                    self.navigationController?.pushViewController(lookbackVC, animated: true)
                }
                return feelingCardCVC
            default:
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
                return spendCVC
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WriteVC: UICollectionViewDelegateFlowLayout {
    
    /// 섹션에 따라 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == goalCategoryCV {
            if indexPath.row == 0 {
                return CGSize(width: 52, height: 29)
            } else {
                
                /// 글씨 길이에 따라 너비 동적 조절
                return CGSize(width: category[indexPath.row - 1].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 32, height: 29)
            }
        } else {
            switch indexPath.section {
            case 0:
                return CGSize(width: 343.adjusted, height: 157.adjustedH)
            case 1:
                return CGSize(width: 343.adjusted, height: 118)
            default:
                return CGSize(width: 166.adjusted, height: 188)
            }
        }
    }
    
    /// 섹션에 인셋 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == goalCategoryCV {
            return UIEdgeInsets(top: 7, left: 16, bottom: 6, right: 16)
        } else {
            switch section {
            case 0:
                return UIEdgeInsets(top: 13, left: 16, bottom: 16, right: 16)
            case 1:
                return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
            default:
                return UIEdgeInsets(top: 12, left: 16, bottom: 16, right: 16)
            }
        }
    }
    
    /// 섹션 별 셀 위아래 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0, 1:
            return 0
        default:
            return 12
        }
    }
    
    /// CV, 섹션 별 셀 좌우 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == goalCategoryCV {
            return 8
        } else {
            switch section {
            case 0, 1:
                return 0
            default:
                return 11
            }
        }
    }
}
