//
//  PomeHalfModalVC.swift
//  POME-iOS
//
//  Created by Juhyeon Byun on 2022/07/12.
//

import UIKit

class PomeHalfModalVC: UIPresentationController {
    
    // MARK: Properties
    let backView = UIView()
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    var modalHeight: CGFloat = 0
    
    /// dismiss 될 때 알려주기 위한 클로저
    var reselectFirstItem: (() -> ())?
    
    /// 배경 (반투명 검정)에 대한 처리
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        backView.backgroundColor = UIColor.black
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        backView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.backView.isUserInteractionEnabled = true
        self.backView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    /// 보여질 HalfModalView 프레임 설정
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * CGFloat(812 - modalHeight)/812),
               size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height  * CGFloat(modalHeight)/812))
    }
    
    /// present 시작할 때
    override func presentationTransitionWillBegin() {
        self.backView.alpha = 0
        self.containerView?.addSubview(backView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.backView.alpha = 0.45
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    }
    
    /// dismiss 시작될 때
    override func dismissalTransitionWillBegin() {
        reselectFirstItem?()
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.backView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.backView.removeFromSuperview()
        })
    }
    
    /// 하프 모달 뷰 radius 설정
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.clipsToBounds = true
        presentedView?.layer.cornerRadius = 16.adjusted
        presentedView?.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    /// 하위뷰 배치가 마쳤음을 알림 이후 VC 변경됨
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        backView.frame = containerView!.bounds
    }
}

// MARK: - @objc
extension PomeHalfModalVC {
    
    /// dismiss처리
    @objc func dismissController(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
