//
//  PushAnimation.swift
//  SwiftTest
//
//  Created by 王欣 on 2019/5/22.
//  Copyright © 2019 王欣. All rights reserved.
//

import UIKit

public class PushAnimation: NSObject {
    
    @objc private var operation:UINavigationController.Operation = .none
    @objc private var interaction:UIPercentDrivenInteractiveTransition?
    @objc weak var navigation:UINavigationController?
    
    @objc override public init() {
        super.init()
    }
    
    public func bindView(navigation:UINavigationController) {
        self.navigation = navigation
        navigation.delegate = self
        setupGes()
    }
    
    @objc public func removeBind() {
        
        navigation?.view.removeGestureRecognizer(ges)
        self.navigation = nil
        navigation?.delegate = nil
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

extension PushAnimation:UINavigationControllerDelegate{
    
    @objc public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interaction
    }
    
   @objc public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) ->
        UIViewControllerAnimatedTransitioning? {
            
            self.operation = operation
            return self
    }
    
}

extension PushAnimation:UIViewControllerAnimatedTransitioning{
    
   @objc public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
   @objc public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.operation == .push{
            print("push")
            if let toview = transitionContext.view(forKey: UITransitionContextViewKey.to),let fromView = transitionContext.view(forKey: .from),let toControl = transitionContext.viewController(forKey: .to),let fromControl = transitionContext.viewController(forKey: .from){
                if let navigationBar = toControl.navigationController?.navigationBar{
                    transitionContext.containerView.addSubview(toview)
                    toview.originX(toview.frame.size.width)
                    UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {
                        navigationBar.barView?.backgroundColor = toControl.barTintColor
                        navigationBar.titleTextAttributes = toControl.titleTextAttributes
                        navigationBar.tintColor = toControl.tintColor
                        toview.originX(0)
                        fromView.originX(-fromView.bounds.size.width * 0.25)
                        self.setupShadowView(view: toview)
                    }) { (_) in
                        let cancel = transitionContext.transitionWasCancelled
                        if cancel == true {
                            navigationBar.barView?.backgroundColor = fromControl.barTintColor
                            navigationBar.titleTextAttributes = fromControl.titleTextAttributes
                            navigationBar.tintColor = fromControl.tintColor
                        }
                        transitionContext.completeTransition(!cancel)
                    }
                }
            }
            
        }else if operation == .pop{
            print("pop")
            if let toview = transitionContext.view(forKey: UITransitionContextViewKey.to),let fromView = transitionContext.view(forKey: .from),let toControl = transitionContext.viewController(forKey: .to) ,let fromControl = transitionContext.viewController(forKey: .from){
                if let navigationBar = toControl.navigationController?.navigationBar{
                    transitionContext.containerView.insertSubview(toview, belowSubview: fromView)
                    
                    toview.originX(-fromView.bounds.size.width * 0.25)
                    UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseIn], animations: {
                        navigationBar.barView?.backgroundColor = toControl.barTintColor
                        navigationBar.titleTextAttributes = toControl.titleTextAttributes
                        navigationBar.tintColor = toControl.tintColor
                        fromView.originX(toview.frame.size.width)
                        toview.originX(0)
                        self.setupShadowView(view: fromView)
                    }) { (_) in
                        let cancel = transitionContext.transitionWasCancelled
                        if cancel == true {
                            navigationBar.barView?.backgroundColor = fromControl.barTintColor
                            navigationBar.titleTextAttributes = fromControl.titleTextAttributes
                            navigationBar.tintColor = fromControl.tintColor
                        }
                        transitionContext.completeTransition(!cancel)
                        
                    }
                }
            }
        }else{
            print("其他")
        }
    }
    
   @objc func setupShadowView(view:UIView) {
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.init(width: -4, height: 6)
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowRadius = 2
    }
    
    
    
}

