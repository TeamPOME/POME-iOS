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
    private var category = ["목표를 정해요", "목표 선택", "목표 설정", "목표 진행", "목표 완료"]
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGoalCategoryCV()
        setWriteMainCV()
        configureNaviBar()
    }
}

// MARK: - UI
extension WriteVC {
    
    private func configureNaviBar() {
        writeHomeNaviBar.setNaviStyle(state: .greyWithRightBtn)
    }
}

// MARK: - UICollectionViewDelegate
extension WriteVC: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDataSource
extension WriteVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let num = (collectionView == goalCategoryCV) ? 1 : 3
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var num = 0
        if collectionView == goalCategoryCV {
            num = category.count
        } else {
            num = (section == 0 || section == 1) ? 1 : 10
        }
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cvc = UICollectionViewCell()
        if collectionView == goalCategoryCV {
            guard let goalCategoryCVC = goalCategoryCV.dequeueReusableCell(withReuseIdentifier: GoalCategoryCVC.className, for: indexPath) as? GoalCategoryCVC else { return UICollectionViewCell() }
            
            /// plus 버튼 추가
            let editButton = UIButton(frame: CGRect(x: 16, y: (42 / 2) - (29 / 2), width: 52, height:29))
            editButton.setImage(UIImage(named: "btnGoalCategory"), for: UIControl.State.normal)
            
            // TODO: - 클릭 시 카테고리 추가로 이동
            //            editButton.addTarget(self, action: <#Selector#>, for: UIControl.Event.touchUpInside)
            
            goalCategoryCV.addSubview(editButton)
            
            /// 셀 텍스트 변경
            goalCategoryCVC.goalLabel.text = category[indexPath.row]
            cvc = goalCategoryCVC
            
            /// 목표 카테고리의 첫 아이템을 디폴트로 설정
            if indexPath.item == 1 {
                cvc.isSelected = true
                goalCategoryCV.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .right)
            }
        } else {
            guard let EmptyGoalCardCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: EmptyGoalCardCVC.className, for: indexPath) as? EmptyGoalCardCVC else { return UICollectionViewCell() }
            guard let feelingCardCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: FeelingCardCVC.className, for: indexPath) as? FeelingCardCVC else {
                return UICollectionViewCell() }
            guard let spendCVC = writeMainCV.dequeueReusableCell(withReuseIdentifier: SpendCVC.className, for: indexPath) as? SpendCVC else { return UICollectionViewCell() }
            
            switch indexPath.section {
            case 0:
                if category.count == 0 {
                    cvc = EmptyGoalCardCVC
                } else {
                    cvc = EmptyGoalCardCVC
                }
            case 1:
                cvc = feelingCardCVC
            default:
                cvc = spendCVC
            }
        }
        return cvc
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WriteVC: UICollectionViewDelegateFlowLayout {
    
    /// 섹션에 따라 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
        if collectionView == goalCategoryCV {
            
            /// 글씨 길이에 따라 너비 동적 조절
            size = CGSize(width: category[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 32, height: 29)
        } else {
            switch indexPath.section {
            case 0:
                size = CGSize(width: 343.adjusted, height: 157)
            case 1:
                size = CGSize(width: 343.adjusted, height: 118)
            default:
                size = CGSize(width: 166.adjusted, height: 188)
            }
        }
        return size
    }
    
    /// 섹션에 인셋 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var inset = UIEdgeInsets()
        if collectionView == goalCategoryCV {
            inset = UIEdgeInsets(top: 7, left: 76, bottom: 6, right: 0)
        } else {
            switch section {
            case 0:
                inset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
            case 1:
                inset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
            default:
                inset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
            }
        }
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0, 1:
            return 0
        default:
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        var spacing = 0
        if collectionView == goalCategoryCV {
            spacing = 8
        } else {
            switch section {
            case 0, 1:
                spacing = 0
            default:
                spacing = 11
            }
        }
        return CGFloat(spacing)
    }
}

// MARK: - Custom Methods
extension WriteVC {
    
    private func setWriteMainCV() {
        writeMainCV.delegate = self
        writeMainCV.dataSource = self
        FeelingCardCVC.register(target: writeMainCV)
        EmptyGoalCardCVC.register(target: writeMainCV)
        SpendCVC.register(target: writeMainCV)
    }
    
    private func setGoalCategoryCV() {
        goalCategoryCV.delegate = self
        goalCategoryCV.dataSource = self
        GoalCategoryCVC.register(target: goalCategoryCV)
    }
}
