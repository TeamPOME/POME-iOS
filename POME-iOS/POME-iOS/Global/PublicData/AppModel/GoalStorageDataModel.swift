//
//  GoalDataModel.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/08.
//

import Foundation

struct GoalDataModel {
    let goalTitle: String
    let spentMoney: Int
    let goalMoney: Int
    let ifSuccessOrNot: Bool
    var ifSuccessOrNotLabelText: String? {
        if ifSuccessOrNot == true
        { return "성공" }
        else { return "실패" }
    }
    let successPercentage: Double
    var spentMoneyLabel: String? {
        return "\(spentMoney)원"
    }
    var goalMoneyLabel: String? {
        return "/ \(goalMoney)원"
    }
}

extension GoalDataModel {
    static let sampleData: [GoalDataModel] =
    [
        GoalDataModel(
            goalTitle: "술을 한달에 적당히 먹자", spentMoney: 10000, goalMoney: 1000000, ifSuccessOrNot: true, successPercentage: 90),
        GoalDataModel(goalTitle: "건강을 위해 줄이자, 술!", spentMoney: 110000, goalMoney: 1000000, ifSuccessOrNot: false, successPercentage: 50),
        GoalDataModel(goalTitle: "특별한 날만 술먹기로 약속", spentMoney: 50000, goalMoney: 1000000, ifSuccessOrNot: true, successPercentage: 30),
        GoalDataModel(goalTitle: "건강을 위해 줄이자", spentMoney: 50000, goalMoney: 1000000, ifSuccessOrNot: true, successPercentage: 110),
        GoalDataModel(
        goalTitle: "술을 한달에 적당히 먹자", spentMoney: 10000, goalMoney: 1000000, ifSuccessOrNot: true, successPercentage: 90),
        GoalDataModel(goalTitle: "건강을 위해 줄이자, 술!", spentMoney: 110000, goalMoney: 1000000, ifSuccessOrNot: false, successPercentage: 10),
        GoalDataModel(goalTitle: "특별한 날만 술먹기로 약속", spentMoney: 50000, goalMoney: 1000000, ifSuccessOrNot: true, successPercentage: 110),
        GoalDataModel(goalTitle: "건강을 위해 줄이자", spentMoney: 50000, goalMoney: 1000000, ifSuccessOrNot: true, successPercentage: 50)
    ]
}
