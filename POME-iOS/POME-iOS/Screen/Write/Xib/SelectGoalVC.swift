//
//  SelectGoalVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/19.
//

import UIKit

class SelectGoalVC: BaseVC {
    
    // MARK: Properties
    private let goalList = ["커피", "아이스크림", "외식", "아이스크림", "차", "담배", "술", "생일", "쇼핑", "OTT"]
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension SelectGoalVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let goalTVC = goalTV.dequeueReusableCell(withIdentifier: goalTVC.className, for: indexPath) as? goalTVC else { return UITableViewCell() }
        goalTVC.goalLabel.text = goalList[indexPath.row]
        return goalTVC
    }
    
    
}

