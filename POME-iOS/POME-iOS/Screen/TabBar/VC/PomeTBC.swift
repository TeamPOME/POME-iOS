//
//  PomeTBC.swift
//  POME-iOS
//
//  Created by EUNJU on 2022/07/06.
//

import UIKit

class PomeTBC: UITabBarController {

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarItemStyle()
        configureTabBar()
        applyShadowTabBar()
    }
}

// MARK: - UI
extension PomeTBC {
    
    /// 탭바 아이템 생성하는 메서드
    func makeTabVC(vcType: TypeOfViewController, tabBarTitle: String, tabBarImg: String, tabBarSelectedImg: String) -> UIViewController {
        
        let tab = ViewControllerFactory.viewController(for: vcType)
        tab.tabBarItem = UITabBarItem(title: tabBarTitle,
                                      image: UIImage(named: tabBarImg)?.withRenderingMode(.alwaysOriginal),
                                      selectedImage: UIImage(named: tabBarSelectedImg)?.withRenderingMode(.alwaysOriginal))
        tab.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        return tab
    }
    
    /// 탭바 아이템 스타일 설정하는 메서드
    func configureTabBarItemStyle() {
        tabBar.unselectedItemTintColor = .grey_5
        tabBar.tintColor = .main
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.PretendardSB(size: 10.0)], for: .normal)
    }
    
    /// 탭바 구성하는 메서드
    func configureTabBar() {
        
        let writeTab = makeTabVC(vcType: .write, tabBarTitle: "기록", tabBarImg: "icRecordMono", tabBarSelectedImg: "icRecordMint")
        let remindTab = makeTabVC(vcType: .remind, tabBarTitle: "회고", tabBarImg: "icRecollectMono", tabBarSelectedImg: "icRecollectMint")
        let mateTab = makeTabVC(vcType: .mate, tabBarTitle: "친구", tabBarImg: "icFriendsMono", tabBarSelectedImg: "icFriendsMint")
        let mypageTab = makeTabVC(vcType: .mypage, tabBarTitle: "마이", tabBarImg: "icMyMono", tabBarSelectedImg: "icMyMint")
        
        // 탭 구성
        let tabs = [writeTab, remindTab, mateTab, mypageTab]
        
        // VC에 루트로 설정
        self.setViewControllers(tabs, animated: false)
    }
    
    /// 탭바에 그림자 적용하는 메서드
    func applyShadowTabBar() {
        
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: UIColor.shadowDefault, alpha: 0.6, x: 0, y: -10, blur: 14)

    }
}
