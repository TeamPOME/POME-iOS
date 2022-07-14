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
    private var category: [String] = ["목표를 정해요", "목표 선택", "목표 설정", "목표 진행", "목표 완료", "목표를 정해요", "목표 선택", "목표 설정", "목표 진행", "목표 완료"]
    private var spend: [String] = ["spend1", "spend2", "spend3", "spend4"]
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        registerCV()
        configureNaviBar()
        configureCategoryCV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setDefaultSelectedCell()
    }
}

// MARK: - UI
extension WriteVC {
    
    private func configureNaviBar() {
        writeHomeNaviBar.setNaviStyle(state: .greyWithRightBtn)
    }
    
    private func configureCategoryCV() {
        
        /// plus 버튼 추가
        let plusBtn = UIButton(frame: CGRect(x: 16, y: (42 / 2) - (29 / 2), width: 52.adjusted, height:29))
        plusBtn.setImage(UIImage(named: "btnGoalCategory"), for: UIControl.State.normal)
        
        // TODO: - 클릭 시 카테고리 추가로 이동
        // plusBtn.addTarget(self, action: <#Selector#>, for: UIControl.Event.touchUpInside)
        
        goalCategoryCV.addSubview(plusBtn)
    }
    
    /// 목표 카테고리의 첫 아이템을 디폴트로 설정
    private func setDefaultSelectedCell() {
        self.goalCategoryCV.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .left)
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
        
        // TODO: - GoalCardCVC 등록 필요
        // GoalCardCVC.register(target: writeMainCV)
        GoalCategoryCVC.register(target: goalCategoryCV)
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
            return category.count
        } else {
            return (section == 2) ? spend.count : 1
        }
    }
    
    // CV, 섹션 별 셀 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let EmptyGoalCardCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: EmptyGoalCardCVC.className, for: indexPath) as? EmptyGoalCardCVC,
        let feelingCardCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: FeelingCardCVC.className, for: indexPath) as? FeelingCardCVC,
        let spendCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: SpendCVC.className, for: indexPath) as? SpendCVC,
        let goalCategoryCVC = goalCategoryCV.dequeueReusableCell(withReuseIdentifier: GoalCategoryCVC.className, for: indexPath) as? GoalCategoryCVC else { return UICollectionViewCell() }

        
        if collectionView == goalCategoryCV {
            goalCategoryCVC.goalLabel.text = category[indexPath.row]
            return goalCategoryCVC
        } else {
            switch indexPath.section {
            case 0:
                if category.count == 0 {
                    EmptyGoalCardCVC.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.1, radius: 15)
                    return EmptyGoalCardCVC
                } else {
                    
                    // TODO: - GoalCardCVC로 변경 필요
                    EmptyGoalCardCVC.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.1, radius: 15)
                    return EmptyGoalCardCVC
                }
            case 1:
                return feelingCardCVC
            default:
                spendCVC.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.12, radius: 4)
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
            
            /// 글씨 길이에 따라 너비 동적 조절
            return CGSize(width: category[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 32, height: 29)
        } else {
            switch indexPath.section {
            case 0:
                return CGSize(width: 343.adjusted, height: 157)
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
            return UIEdgeInsets(top: 7, left: 76, bottom: 6, right: 16)
        } else {
            switch section {
            case 0:
                return UIEdgeInsets(top: 13, left: 16, bottom: 16, right: 16)
            case 1:
                return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
            default:
                return UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16)
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
