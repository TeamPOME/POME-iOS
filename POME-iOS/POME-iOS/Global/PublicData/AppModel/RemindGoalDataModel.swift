//
//  RemindGoalDataModel.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/14.
//

import Foundation

struct RemindGoalDataModel {
    let privateGoal: Bool
    let goalTitle: String
    let spentMoney: Int
    var spentMoneyLabel: String? {
        return "\(spentMoney)원"
    }
    let content: String
    let time: Int
    var timeLabel: String? {
        return "\(time)시간 전"
    }
    let countMate: Int
}

extension RemindGoalDataModel {
    static let sampleData: [RemindGoalDataModel] = [
        RemindGoalDataModel(privateGoal: true, goalTitle: "커피 대신 물을 마시자", spentMoney: 320800, content: "흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐", time: 1, countMate: 9),
        RemindGoalDataModel(privateGoal: true, goalTitle: "커피 대신 물을 마시자", spentMoney: 320800, content: "흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐", time: 1, countMate: 0),
        RemindGoalDataModel(privateGoal: false, goalTitle: "커피 대신 물을 마시자", spentMoney: 320800, content: "흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐", time: 1, countMate: 1),
        RemindGoalDataModel(privateGoal: true, goalTitle: "커피 대신 물을 마시자", spentMoney: 320800, content: "흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐", time: 1, countMate: 2),
        RemindGoalDataModel(privateGoal: false, goalTitle: "커피 대신 물을 마시자", spentMoney: 320800, content: "흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐", time: 1, countMate: 3),
        RemindGoalDataModel(privateGoal: false, goalTitle: "커피 대신 물을 마시자", spentMoney: 320800, content: "흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐", time: 1, countMate: 9),
        RemindGoalDataModel(privateGoal: true, goalTitle: "커피 대신 물을 마시자", spentMoney: 320800, content: "흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐흐", time: 24, countMate: 9) ]
}
