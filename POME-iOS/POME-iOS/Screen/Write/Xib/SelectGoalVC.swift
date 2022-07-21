//
//  SelectGoalVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/19.
//

import UIKit

class SelectGoalVC: BaseVC {
    
    // MARK: Properties
    var goalList: [GetGoalsResModel] = []
    var selectGoalDelegate: SelectGoalDelegate!
    
    // MARK: IBOutlet
    @IBOutlet weak var goalTV: UITableView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        registerTVC()
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
