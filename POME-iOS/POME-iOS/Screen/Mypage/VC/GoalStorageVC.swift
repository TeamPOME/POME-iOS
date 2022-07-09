//
//  GoalStorageVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/08.
//

import UIKit

class GoalStorageVC: BaseVC {
    
    // MARK: Properties
    private let goalStoarageTV = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .grey_0
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let naviBar = PomeNaviBar().then {
        $0.setNaviStyle(state: .greyBackDefault)
    }
    
    private let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.adjusted, height: 45.adjustedH)).then {
        $0.backgroundColor = .grey_0
    }
    
    private let titleHeaderLabel = UILabel().then {
        $0.setLabel(text: "완료한 목표", color: .black, size: 18, weight: .bold)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTV()
        setDelegate()
    }
}

// MARK: - UI
extension GoalStorageVC {
    
    private func configureView() {
        view.backgroundColor = .grey_0
        view.addSubview(goalStoarageTV)
        view.addSubview(naviBar)
        headerView.addSubview(titleHeaderLabel)
        goalStoarageTV.tableHeaderView = headerView
    }
    
    private func configureUI() {
        configureView()
        
        naviBar.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleHeaderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        goalStoarageTV.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(naviBar.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Custom Methods
extension GoalStorageVC {
    
    private func setTV(){
        GoalCardTVC.register(target: goalStoarageTV)
    }
}

// MARK: - Delegate
extension GoalStorageVC {
    
    private func setDelegate() {
        goalStoarageTV.delegate = self
        goalStoarageTV.dataSource = self
    }
}

// MARK: - UITableViewDelegate
extension GoalStorageVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.GoalCardTVC, for: indexPath) as? GoalCardTVC else { return UITableViewCell() }
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.grey_0.cgColor
        cell.setData(GoalDataModel.sampleData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension GoalStorageVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GoalDataModel.sampleData.count
    }
}
