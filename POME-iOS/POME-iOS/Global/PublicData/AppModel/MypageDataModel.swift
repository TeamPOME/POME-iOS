//
//  MypageDataModel.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/17.
//

import Foundation
import UIKit

struct MypageDataModel {
    let endGoalNum: Int
    var content: String? {
        return "다시 보고 싶은 지난 목표가 \(endGoalNum)건 있어요"
    }
    let mypageName: String?
    let mypageImageName: String?
    var mypageImage: UIImage? {
        return UIImage(named: mypageImageName ?? "userProfileFill32")
    }
}

extension MypageDataModel {
    static let sampleData: [MypageDataModel] =
    [
        MypageDataModel(endGoalNum: 11, mypageName: "포포", mypageImageName: "userProfileFill32")
    ]
}
