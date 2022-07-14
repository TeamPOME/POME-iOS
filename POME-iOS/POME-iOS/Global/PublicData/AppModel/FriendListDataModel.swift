//
//  FriendListDataModel.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/14.
//

import UIKit

struct FriendListData {
    let nickname: String
    let profileImageName: String
    
    func makeProfileImage() -> UIImage? {
        return UIImage(named: profileImageName)
    }
}
