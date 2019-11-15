//
//  PushAnimation.swift
//  SwiftTest
//
//  Created by 王欣 on 2019/5/22.
//  Copyright © 2019 王欣. All rights reserved.
//

import UIKit

public class PushAnimation: NSObject {
    
    @objc public var operation:UINavigationController.Operation = .none
    @objc public var interaction:UIPercentDrivenInteractiveTransition?
    @objc weak var navigation:UINavigationController?
    
    @objc override public init() {
        super.init()
    }
    
    public func bindView(navigation:UINavigationController) {
        self.navigation = navigation
        setupGes()
    }
    
    @objc public func removeBind() {        
        navigation?.view.removeGestureRecognizer(ges)
        self.navigation = nil
    }
    
    private lazy var ges: UIScreenEdgePanGestureRecognizer = {
        let ges = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(screenGes(ges:)))
        ges.edges = .left
        return ges
    }()
    
    private func setupGes() {
        navigation!.view.addGestureRecognizer(ges)
    }
    
    @objc private func screenGes(ges:UIScreenEdgePanGestureRecognizer){
        if navigation?.viewControllers.count == 0 {return}
        let width = UIScreen.main.bounds.size.width
        let offset = ges.translation(in: ges.view).x
        let vocity = ges.velocity(in: ges.view).x;
        let percent = offset/width;
        let state = ges.state
        switch state {
        case .began:
            interaction = UIPercentDrivenInteractiveTransition()
            interaction?.completionCurve = .linear
            navigation?.popViewController(animated: true)
        case .changed:
            if let inter = interaction{
                inter.update(percent)
            }
        case .cancelled:
            interaction!.cancel()
            interaction = nil
        case .ended:
            if vocity > 500{
                interaction!.finish()
            }else{
                if percent > 0.5{
                    interaction!.finish()
                }else{
                    interaction!.cancel()
                }
            }
            interaction = nil
        default:
            interaction?.cancel()
            interaction = nil
        }
    }
    
    
}


extension PushAnimation:UIViewControllerAnimatedTransitioning{
    
    @objc public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    @objc public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let toControl = transitionContext.viewController(forKey: .to) , let fromControl = transitionContext.viewController(forKey: .from),let fromView = transitionContext.view(forKey: .from), let toView = transitionContext.view(forKey: .to),let navigationBar = navigation?.navigationBar {
            var fromViewNewOrigin = -fromView.bounds.size.width * 0.25
            var toViewNewOrigin:CGFloat = 0
            var toViewOldOrigin:CGFloat = 0
            if self.operation == .push{
                transitionContext.containerView.addSubview(toView)
                fromViewNewOrigin = -fromView.bounds.size.width * 0.25
                toViewNewOrigin = 0
                toViewOldOrigin = toView.frame.size.width
            }else{
                transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
                fromViewNewOrigin = toView.frame.size.width
                toViewNewOrigin = 0
                toViewOldOrigin = -fromView.bounds.size.width * 0.25
            }
            toView.originX(toViewOldOrigin)
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseInOut], animations: {
                navigationBar.barTintColor = toControl.barTintColor
                navigationBar.titleTextAttributes = toControl.titleTextAttributes
                navigationBar.tintColor = toControl.tintColor
                toView.originX(toViewNewOrigin)
                fromView.originX(fromViewNewOrigin)
                self.setupShadowView(view: toView)
            }) { (_) in
                let cancel = transitionContext.transitionWasCancelled
                if cancel == true {
                    navigationBar.barTintColor = fromControl.barTintColor
                    navigationBar.titleTextAttributes = fromControl.titleTextAttributes
                    navigationBar.tintColor = fromControl.tintColor
                }
                transitionContext.completeTransition(!cancel)
            }
            
        }else{
            transitionContext.completeTransition(false)
        }
    }
    
    @objc func setupShadowView(view:UIView) {
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize.init(width: -4, height: 6)
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowRadius = 2
    }
    
    
    
}

