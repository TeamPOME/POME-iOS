//
//  SelectGoalVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/19.
//

import UIKit

class SelectGoalVC: BaseVC {
    
    // MARK: Properties
    private var goalList: [GetGoalsResModel] = []
    var selectGoalDelegate: SelectGoalDelegate!
    
    // MARK: IBOutlet
    @IBOutlet weak var goalTV: UITableView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        registerTVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getGoalGategory()
    }
    
    // MARK: IBAction
    @IBAction func tapCloseBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

// MARK: - Custom Methods
extension SelectGoalVC {
    
    private func setDelegate() {
        goalTV.delegate = self
        goalTV.dataSource = self
    }
    
    private func registerTVC() {
        goalTVC.register(target: goalTV)
    }
}

// MARK: - UITableViewDelegate
extension SelectGoalVC: UITableViewDelegate {
    
    /// 셀 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    /// 셀 선택 시 원래의 VC로 데이터 전달
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectGoalDelegate?.selectGoal(goalId: goalList[indexPath.row].id, goalLabel: goalList[indexPath.row].category)
        self.dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SelectGoalVC: UITableViewDataSource {
    
    /// 셀 개수 지정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let goalTVC = goalTV.dequeueReusableCell(withIdentifier: goalTVC.className, for: indexPath) as? goalTVC else { return UITableViewCell() }
        goalTVC.selectionStyle = .none
        goalTVC.goalLabel.text = goalList[indexPath.row].category
        return goalTVC
    }
}

// MARK: - Network
extension SelectGoalVC {
    
    /// 목표 카테고리 조회 요청 메서드
    private func getGoalGategory() {
        WriteAPI.shared.getGoalsAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? [GetGoalsResModel] {
                    DispatchQueue.main.async {
                        self.goalList = data
                        self.goalTV.reloadData()
                    }
                }
            case .requestErr:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            default:
                self.makeAlert(title: "네트워크 오류로 인해\n데이터를 불러올 수 없습니다.\n다시 시도해 주세요.")
            }
        }
    }
}
