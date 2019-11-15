//
//  BaseViewController.swift
//  TransitioningExample
//
//  Created by 王欣 on 11/14/19.
//  Copyright © 2019 王欣. All rights reserved.
//

import UIKit
import Transitioning
class BaseViewController:UINavigationController {
    let pushAnimation = PushAnimation.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        pushAnimation.bindView(navigation: self)
        self.navigationBar.isTranslucent = true
        self.delegate = self
        
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension BaseViewController:UINavigationControllerDelegate{
    
    @objc public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return pushAnimation.interaction
    }
    
    @objc public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        pushAnimation.operation = operation
        return pushAnimation
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
//        if viewController is ViewController {
//            navigationController.setNavigationBarHidden(true, animated: true)
//        }else{
//            viewController.navigationController?.setNavigationBarHidden(false, animated: true)
//        }
        
    }
    
}

