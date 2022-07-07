//
//  TypeOfVC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/07.
//

import Foundation

enum TypeOfViewController {
    case tabBar
    case write
    case remind
    case mate
    case mypage
}

extension TypeOfViewController {
    func storyboardRepresentation() -> StoryboardRepresentation {
        switch self {
            
        case .tabBar:
            return StoryboardRepresentation(bundle: nil, storyboardName: "", storyboardId: PomeTBC.className)
        case .write:
            return StoryboardRepresentation(bundle: nil, storyboardName: Identifiers.WriteSB, storyboardId: WriteNC.className)
        case .remind:
            return StoryboardRepresentation(bundle: nil, storyboardName: Identifiers.RemindSB, storyboardId: RemindNC.className)
        case .mate:
            return StoryboardRepresentation(bundle: nil, storyboardName: Identifiers.MateSB, storyboardId: MateNC.className)
        case .mypage:
            return StoryboardRepresentation(bundle: nil, storyboardName: Identifiers.MypageSB, storyboardId: MypageNC.className)
        }
    }
}
