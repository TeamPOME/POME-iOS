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
    @IBOutlet weak var emptyViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emptyView: UIStackView!
    
    // MARK: Properties
    var goalTitle: String = ""
    var selectedGoalId: Int = 1
    private var record: [Record] = []
    
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
        getIncompleteRecord(goalId: selectedGoalId)
        configureEmptyView()
    }
}

// MARK: - UI
extension LookbackVC {
    
    private func configureNaviBar() {
        naviBar.setNaviStyle(state: .greyBackDefault)
    }
    
    private func configureEmptyView() {
        emptyViewTopConstraint.constant = screenHeight == 667 ? 445.adjustedH : 482.adjustedH
        emptyView.isHidden = !(record.count == 0)
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
        return (section == 0) ? 1 : record.count
    }
    
    /// 섹션 별 셀 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let lookbackCVC = lookbackMainCV.dequeueReusableCell(withReuseIdentifier: LookbackCVC.className, for: indexPath) as? LookbackCVC,
              let spendCVC = lookbackMainCV.dequeueReusableCell(withReuseIdentifier: SpendCVC.className, for: indexPath) as? SpendCVC else { return UICollectionViewCell() }
        
        if indexPath.section == 0 {
            lookbackCVC.setData(goal: goalTitle, num: record.count)
            lookbackCVC.goalBgView.makeRounded(cornerRadius: 6.adjusted)
            lookbackCVC.goalBgView.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.1, radius: 15)
            return lookbackCVC
        } else {
            if record.count > 0 {
                spendCVC.makeRounded(cornerRadius: 6.adjusted)
                spendCVC.addShadow(offset: CGSize(width: 0, height: 0), color: .cellShadow, opacity: 0.12, radius: 4)
                spendCVC.setData(data: record[indexPath.row], isWriteVC: false)
                
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
            }
            return spendCVC
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
            return CGSize(width: 166.adjusted, height: 192.adjustedH)
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

// MARK: - Network
extension LookbackVC {
    
    /// 되돌아 볼  씀씀이 조회 요청 메서드
    private func getIncompleteRecord(goalId: Int) {
        self.activityIndicator.startAnimating()
        WriteAPI.shared.getIncompleteRecordAPI(goalId: goalId) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GetIncompleteRecordResModel {
                    DispatchQueue.main.async {
                        self.record = data.records
                        self.lookbackMainCV.reloadData()
                        self.configureEmptyView()
                    }
                    self.activityIndicator.stopAnimating()
                }
            case .requestErr:
                self.activityIndicator.stopAnimating()
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.activityIndicator.stopAnimating()
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}
