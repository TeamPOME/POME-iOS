//
//  GoalStorageVC.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/08.
//

import UIKit

class GoalStorageVC: BaseVC {
    
    // MARK: Properties
    private let goalStoarageTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .grey_0
    }
    
    private let naviBar = PomeNaviBar().then {
        $0.setNaviStyle(state: .greyBackDefault)
    }
    
    private let header = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.adjusted, height: 45.adjustedH)).then {
        $0.backgroundColor = .grey_0
    }
    
    private let titleHeaderLabel = UILabel().then {
        $0.setLabel(text: "완료한 목표", color: .black, size: 18, weight: .bold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDelegate()
    }
}

// MARK: - UI
extension GoalStorageVC {
    
    private func setTV(){
        GoalCardTVC.register(target: goalStoarageTableView)
    }
    
    private func configureView() {
        view.backgroundColor = .grey_0
        view.addSubview(goalStoarageTableView)
        view.addSubview(naviBar)
        header.addSubview(titleHeaderLabel)
        goalStoarageTableView.tableHeaderView = header
    }
    
    private func setSectionSpacing() {
        goalStoarageTableView.sectionFooterHeight = 6.0
        goalStoarageTableView.sectionHeaderHeight = 0.0
        goalStoarageTableView.sectionHeaderTopPadding = 0
    }
    
    private func configureUI() {
        configureView()
        
        naviBar.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleHeaderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        goalStoarageTableView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.top.equalTo(naviBar.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        setTV()
        configureView()
        setSectionSpacing()
    }
}

// MARK: - Delegate
extension GoalStorageVC {
    
    private func setDelegate() {
        goalStoarageTableView.delegate = self
        goalStoarageTableView.dataSource = self
    }
}

// MARK: - TableView
extension GoalStorageVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.GoalCardTVC, for: indexPath) as? GoalCardTVC else { return UITableViewCell() }
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.grey_0.cgColor
        cell.setData(GoalDataModel.sampleData[indexPath.section])
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return GoalDataModel.sampleData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
