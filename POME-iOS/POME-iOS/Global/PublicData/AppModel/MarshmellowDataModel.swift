//
//  MarshmellowDataModel.swift
//  POME-iOS
//
//  Created by 한유진 on 2022/07/17.
//

import Foundation
import UIKit

struct MarshmellowDataModel {
    let levelInt: Int
    var levelLabel: String? {
        return "Lv.\(levelInt)"
    }
    let levelBadge: String
    let marshmellowImageName: String?
    var marshmellowImage: UIImage? {
        return UIImage(named: marshmellowImageName ?? "userProfileFill32")
    }
}

extension MarshmellowDataModel {
    static let sampleData: [MarshmellowDataModel] = [
        MarshmellowDataModel(levelInt: 1, levelBadge: "기록말랑", marshmellowImageName: "marshmallowLevel2Blue"),
        MarshmellowDataModel(levelInt: 2, levelBadge: "공감말랑", marshmellowImageName: "marshmallowLevel2Yellow"),
        MarshmellowDataModel(levelInt: 3, levelBadge: "발전말랑", marshmellowImageName: "marshmallowLevel3Pink"),
        MarshmellowDataModel(levelInt: 4, levelBadge: "솔직말랑", marshmellowImageName: "marshmallowLevel4Mint") ]
}
