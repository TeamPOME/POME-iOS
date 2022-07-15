//
//  ProfileCellDelegate.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/15.
//

import Foundation

protocol ProfileCellDelegate: AnyObject {
    func sendFollowingState(indexPath: IndexPath, followingState: Bool)
}
